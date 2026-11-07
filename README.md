# Lecture 15 -  Step 2 - Cloud Storage

In this step we implement Firebase Storage. This also requires the Blaze plan to implement. There have been some changes to the naming convention of the default storage path and we shall explicitly specify the bucket. See more here: [Storage Docs](https://firebase.google.com/docs/storage/flutter/start).

First add Firebase Storage to your project
```zsh
flutter pub add firebase_storage
```
The reference to the `storage` is
```dart
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: "gs://<your-project-id>.firebasestorage.app");
```

#### Upload testing page
1. Create a `User` object in Firestore
2. Pick an image from the Gallery (or Camera)
3. Upload the image to Firebase Storage using a `storagePath` of the form `users/{userId}/images/{imageName}`. Note that with exactly this pattern we can listen to changes in Firebase Storage and take action like processing the image, creating thumbnails etc.
4. Get a `downloadUrl` for this object that enables public Url to the object which can be revoked any time by you
5. Display the image using this `downloadUrl`
6. Implement an upload progress indicator
7. Update the user object with the information about the image we uploaded in an `images` collection residing under the `user` where we store the `downloadUrl` and the `storagePath`

# Creating User
Simple function to add a user
```dart
  void addUser() async {
    _docRef = await FirebaseFirestore.instance
        .collection('users_test')
        .add({'name': 'John Doe', 'email': 'john@doe.com'});
    setState(() {});
  }
```
# Picking an Image
Remember to add the provisioning in [Info.plist](/ios/Runner/Info.plist):
```xml
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Access to the photo libray is needed.</string>
	<key>NSCameraUsageDescription</key>
	<string>Access to the camera is needed.</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Access to the microphone is needed.</string>
```
the Image picker is implemented as:
```dart
  void pickImage() async {
    _xfile = await _picker.pickImage(source: ImageSource.gallery);
    _imagePath = _xfile?.path;
    setState(() {});
  }
```

# Uploading an image
To upload the image we first need to create a reference in `storage` object we defined earlier. For that we define the `storagePath`:
```dart
    String imageName =
        "${p.basenameWithoutExtension(_imagePath!)}_"
        "${DateTime.now().microsecondsSinceEpoch}."
        "${p.extension(_imagePath!)}";
    _storagePath = "users/${_docRef?.id}/images/$imageName";
```
For added security we inject the timestamp in the image name to avoid overwrites. 

As we implemented different methods for **Web** and **Android/iOS** for saving image to gallery or desktop, we need to do the same here. We already have the `SaveImage` class. This was implemented in the following form:
```zsh
save_image
├── save_image.dart         <-- this file to be imported
├── save_image_io.dart      <-- exported ONLY if dart.io library is loaded
├── save_image_other.dart   <-- default export
└── save_image_web.dart     <-- exported ONLY if dart.html library is loaded
```


We add another static method:
```dart
  static Future<String?> uploadImageToStorage(
      {required XFile file,
      required Reference storageReference,
      void Function(double)? progressCallback}) async {
        ...
        return downloadUrl;
        ...
  }
```
which returns a `downloadUrl`. This function is called as:
```dart
    _downloadUrl = await SaveImage.uploadImageToStorage(
    file: _xfile!,
    storageReference: storage.ref(_storagePath),
    progressCallback: progressCallback,
    );
```
#### The image upload details
The full image upload method is:
```dart
  static Future<String?> uploadImageToStorage(
      {required XFile file,
      required Reference storageReference,
      void Function(double)? updateCallback}) async {
    await storageReference.putFile(File(file.path));
    UploadTask task = storageReference.putFile(File(file.path));
    if (updateCallback != null) {
      task.snapshotEvents.listen((event) {
        double progress = event.bytesTransferred / event.totalBytes;
        progressCallback(progress);
      });
    }

    TaskSnapshot snapshot = await task;
    if (snapshot.state == TaskState.success) {
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return null;
    }
  }
```
The first part is creating an `UploadTask` which in itself is a future
```dart
UploadTask task = storageReference.putFile(File(file.path));
```
Then we create a listenable to be able to process progress:
```dart
if (progressCallback != null) {
    task.snapshotEvents.listen((event) {
    double progress = event.bytesTransferred / event.totalBytes;
    progressCallback(progress);
    });
}
```
Here we compare the amount of bytes transferred to the total in order to get a progress number between 0 and 1. Then we submit this number into the `progressCallback` that has been provided. We'll understand how that works a few sections below.

Then we await for the task to finish and get a snapshot, basically the final status of the upload:
```dart
TaskSnapshot snapshot = await task;
```
Depending on the status we can now proceed to get the `downloadUrl` for this file. The `downloadUrl` can be used publicly to access the image but revoked if wanted.
```dart
if (snapshot.state == TaskState.success) {
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
} else {
    return null;
}
```
#### Displaying the image from the internet
Once we have the `downloadUrl`, we can use `Image.network` to display the image. This is achieved after calling `setState()` after receiving the `downloadUrl`:
```dart
   if (_downloadUrl != null)
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                    child: Image.network(_downloadUrl!)),
```

#### Upload progress indicator
To to this, we create a variable named `progress` in the `State` of our `StatefulWidget`. 

The callback function `progressCallback` is a function that will be called by the upload process of Firebase Storage.
```dart
  void progressCallback(double value) {
    setState(() {
      _progress = value;
    });
  }
```
 Each time this function will be passed on the percentage of upload. The function then updates the local variable `progress` and calls `setState()`. This way the `LinearProgressIndicator` repaints itself with the new value of `progress` and we can see an animation of the progress.
 ```dart
    Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 10),
    color: Theme.of(context).colorScheme.primaryContainer,
    child: LinearProgressIndicator(
        value: _progress,
        minHeight: 10,
    ),
    ),
 ```

 #### Updating the `user` object in the database
With the call to Firestore
```dart
    await _docRef
        ?.collection('images')
        .add({
            'imageUrl': _downloadUrl, 
            'imagePath': _storagePath
            });
```
we add a document to the `images` collection of the `user` where we indicate the public Url as well as the reference in Firebase Storage.
> Always keep a copy of the actual reference in the storage. Do not rely on the downloadUrl alone

#### Resulting behaviour
The complete behaviour is seen in this recording:

![Storage Demo](/assets/gifs/StorageUploadDemo.gif)

### Uploading Image in Flutter Web
The `putFile` method doesn't work on Web. We need to read the bytes and then uplaod. In the file `save_image_web.dart`:
```dart
  static Future<String?> uploadImageToStorage({
    required XFile file,
    required Reference storageReference,
    void Function(double)? progressCallback,
  }) async {
    Uint8List fileBytes = await file.readAsBytes();
    SettableMetadata metadata = SettableMetadata(
      contentType: file.mimeType, // e.g., 'image/jpeg', 'application/pdf'
    );
    UploadTask uploadTask = storageReference.putData(fileBytes, metadata);
    TaskSnapshot snapshot = await uploadTask;
    if (progressCallback != null) {
      uploadTask.snapshotEvents.listen((event) {
        progressCallback(event.bytesTransferred / event.totalBytes);
      });
    }
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
```

handles the upload for **Flutter Web**

### CORS issues
In Flutter Web you will encounter **CORS** issues. To solve them we need to run the following script:
```javascript
const { Storage } = require('@google-cloud/storage');
// Initialize storage with your service account credentials
const storage = new Storage({
    keyFilename: '../google_service_account.json',
});
const bucketName = 'csen268-f25.firebasestorage.app';
async function configureBucketCors() {
    await storage.bucket(bucketName).setCorsConfiguration([
        {
            maxAgeSeconds: 3600,
            method: ['GET', 'HEAD', 'OPTIONS'],
            origin: ['http://localhost:54937', 'https://csen268-f25.web.app',
                'https://csen268-f25.firebaseapp.com'], // Change to your specific domain for production
            responseHeader: ['Content-Type', 'Authorization',
                'Content-Length', 'User-Agent'],
        },
    ]);
    console.log(`CORS configuration successfully updated for ${bucketName}`);
}
configureBucketCors().catch(console.error);
```
in the `functions` directory. Note that `google_service_account.json` is downloaded from **Google Cloud Console**. Before running this script, ensure that the package necessary is loaded by calling
```
npm install @google-cloud/storage
```
in the terminal in the `functions` directory.


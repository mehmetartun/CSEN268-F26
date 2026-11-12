# Lecture 16 - 3 Cloud Storage Triggers

We will do an example where we create a base64 string from an image uploaded to cloud storage and save it to firestore database.

## Packages 

We need `sharp` and `path` packages. To do that we use `npm install sharp path`.

In the `index.js` file we import the necessary objects:
```javascript
const { getStorage } = require("firebase-admin/storage");
const { onObjectFinalized } = require("firebase-functions/storage");
const path = require("path");
const sharp = require("sharp");
```

## Trigger for Cloud Storage

The trigger is captured via the `onObjectFinalized` function. The `event` object carries information about the new file created in storage.

```javascript
exports.onImageUploaded = onObjectFinalized(async (event) => {
    const fileBucket = event.data.bucket;
    const filePath = event.data.name;
    const contentType = event.data.contentType;
    const fileName = path.basename(filePath);
...
```

We then determine if this is an image and resize the image and create a `base64` string out of that.
```javascript
if (contentType.startsWith('image/')) {
        const bucket = getStorage().bucket(fileBucket);
        const downloadResponse = await bucket.file(filePath).download();
        const imageBuffer = downloadResponse[0];

        // Create a thumbnail from the image buffer
        const thumbnailBuffer = await sharp(imageBuffer).resize({
            width: 100,
            height: 100,
            withoutEnlargement: true,
        }).toBuffer();

        // Convert the thumbnail buffer to a base64 string
        const thumbnailBase64 = thumbnailBuffer.toString('base64');
        ...
```

Ultimately we save this `base64` string to firestore.
```javascript
 try {
      await getFirestore().collection('images').add({
          fileName: fileName,
          thumbnailBase64: thumbnailBase64,
          createdAt: new Date(),
      });
      logger.info(`Successfully created and stored thumbnail for ${fileName}`);
  } catch (error) {
      logger.error(`Error storing thumbnail for ${fileName}:`, error);
  }
```
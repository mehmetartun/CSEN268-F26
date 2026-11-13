# Lecture 16 - 4 Firebase Cloud Messaging for Individual Users

## Objective
- Create new User using Firebase Authentication
    - As new user is created, create an entity in the Firestore users table with the uid, and email of the user along with other data that comes through from Firebase Authentication
- Update User details on sign in
    - Save the emailVerified status of the user
    - Save the Firebase Cloud Messaging token to the user when the user signs in on a device such that we can send messages to this particular device
- Update token on sign-out
    - When user signs out, we need to remove the FCM token from the user

Firebase Auth provides two blocking functions that are triggered before the user is created, or before the user is signed in:

[Extend Firebase Auth with Blocking Functions](https://firebase.google.com/docs/auth/extend-with-blocking-functions)

## Correct Functions installation
Ensure that your [package.json](functions/package.json) contains the correct versions:
```javascript
  "dependencies": {
    "firebase-admin": "^13.6.0",
    "firebase-functions": "^7.0.0",
    "path": "^0.12.7",
    "sharp": "^0.34.5"
  },
```

    Note that the **Identity Toolkit API** needs to be enabled in your cloud project

## Function for before creation of user
```javascript   
exports.saveUser = beforeUserCreated(async (event) => {
    const user = event.data;
    const db = getFirestore();
    const userRef = db.collection('users').doc(user.uid);
    await userRef.set({
        email: user.email ?? null,
        displayName: user.displayName ?? null,
        photoUrl: user.photoURL ?? null,
        createdAt: Timestamp.now(),
        uid: user.uid,
        emailVerified: user.emailVerified,
    }, { merge: true });
});
```
This enables us to save the user in Firestore database. We can also use this step to block the user creation (eg you only allow users with gmail.com email address..)

## Function for before sign in
```javascript
exports.updateUser = beforeUserSignedIn(async (event) => {
    const user = event.data;
    const db = getFirestore();
    const userRef = db.collection('users').doc(user.uid);
    await userRef.update({
        emailVerified: user.emailVerified,
    });
});
```
We can use this to update user details everytime the user is signed in (for example updates to his photoUrl, displayName, etc. In this case we just update **emailVerified**)

In your **Firebase** console, you need to go to **Authentication** and add these blocking functions in the shown area:
<img src="assets/images/BlockingFunctions.png" width="600">

## Recording and Updating the Firebase Installation ID
We use this function to change the Firebase Intallation ID of the user, when he signs in and also when he signs out. These are called from `AuthenticationBloc` user sign in, sign out, and new user handlers.

The `firebaseInstallationID` is stored in the `AuthenticationBloc`. It's registered there with the event:
```dart
 on<AuthenticationFirebaseInstallationIdReceived>((event, emit) {
      firebaseInstallationID = event.fid;
    });
```
which is added from `NotificationBloc`:
```dart
  void onInstallationID() async {
    authenticationBloc.add(
      AuthenticationFirebaseInstallationIdReceived(
        fid: firebaseInstallationID!,
      ),
    );
  }
```

In the cloud functions we have the function to update the data in the Firestore database:

```javascript
exports.updateUserFid = onCall(async (request) => {
    if (!request.data.uid || !request.data.fid) {
        return { 'message': 'Invalid request' };
    }
    const uid = request.data.uid;
    const fid = request.data.fid;
    const action = request.data.action;
    const db = getFirestore();
    const userRef = db.doc(`users/${uid}`);
    const qs = await userRef.get();
    var fids = qs.data().fids;
    if (!fids) {
        fids = [];
    }
    if (action == 'delete') {
        fids = fids.filter(item => item !== fid);
    } else if (action == 'add') {
        if (!fids.includes(fid)) {
            fids.push(fid);
        }
    }
    await userRef.update({
        fids: fids,
    });
    return { 'message': 'Success' };
});
```

Calling from `AuthenticationBloc` example for sign out. Similar logic for signing in and new user creation.
```dart
  Future<void> _handleSignOut(event, emit) async {
    emit(AuthenticationWaiting());
    user = null;
    FirebaseFunctions.instance.httpsCallable('updateUserFid').call({
      'uid': user?.uid,
      'fid': firebaseInstallationID,
      'action': 'delete',
    });
    await authenticationRepository.signOut();
    emit(AuthenticationInitial());
  }
```

## Testing the messaging functionality
In order to test the messaging functionality we create a small `http` function:
```javascript
exports.sendMessageTest = onRequest(async (request, response) => {
    const email = request.query.email;
    const db = getFirestore();
    const userRef = db.collection('users').where('email', '==', email);
    const qs = await userRef.get();
    if (qs.empty) {
        response.status(404).send('User not found');
        return;
    }
    const user = qs.docs[0].data();
    const fids = user.fids;
    if (!fids || fids.length === 0) {
        response.status(404).send('No FID Found');
        return;
    }
    var messages = [];
    fids.forEach(fid => {
        console.log({
            fid: fid,

            notification: {
                title: 'Test Notification via FID',
                body: 'Sent from Node.js using Firebase Installation ID!',
            },

            data: {
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
                screen: '/profile',
                timestamp: new Date().toISOString(),
            },

            webpush: {
                notification: {
                    icon: '/icons/Icon-192.png',
                },
                fcmOptions: {
                    link: 'http://localhost:58503/',
                },
            },
        });
        messages.push(
          {
            fid: fid,

            notification: {
                title: 'Test Notification via FID',
                body: 'Sent from Node.js using Firebase Installation ID!',
            },

            data: {
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
                screen: '/profile',
                timestamp: new Date().toISOString(),
            },

            webpush: {
                notification: {
                    icon: '/icons/Icon-192.png',
                },
                fcmOptions: {
                    link: 'http://localhost:58503/',
                },
            },
        } 
        );
        // messages.push({ 'fid': fid, 'notification': { 'title': 'Test', 'body': message } });
    });
    await getMessaging().sendEach(messages);
    response.send('Success');
})
```

This function can be called from browser and the user with email, if found, shall receive the message. To call this we use:
```
https://us-central1-csen268-f25.cloudfunctions.net/sendMessageTest?email=mehmet@artun.com&message=HelloWorld
```


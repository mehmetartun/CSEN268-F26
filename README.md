
# Lecture 11 - 04 Messaging

## Steps to implement

1. Add firebase cloud messaging by
```zsh
flutter pub add firebase_messaging
```
2. Create reference to cloud messaging in `main()`
```dart
final messaging = FirebaseMessaging.instance;
```
3. Request permission from the host device
```dart
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
```
4. Go to **Project Settings > Cloud Messaging** and create a Web Push Key.
<img src="/assets/images/CreateVapidKey.png" alt="Generate VAPID Key" width="600">

5. Enable Firebase Installation ID in **Android**

```xml
<application>
  ...
  <meta-data
      android:name="firebase_messaging_installation_id_enabled"
      android:value="true" />

  <!-- Make sure auto-init is also set to true -->
  <meta-data
      android:name="com.google.firebase.messaging.default_notification_channel_id"
      android:value="high_importance_channel" />
  ... 
</application>

```

6. Enable Firebase Installation ID in **iOS**
In the `info.plist` file under `Runner` add the following key value pair:
```xml
<key>FirebaseMessagingAutoInitEnabled</key>
<true/>
```


7. Add your `VAPID Key` to be able to push to Web.
```dart
const vapidKey = "<YOUR_PUBLIC_VAPID_KEY_HERE>"
```

8. Get your **FirebaseInstallationID**. To get the FirebaseInstallationID we need to  register messaging by calling in `main.dart`. But before registering we need to define the `onRegistered` method:
```dart
if (kIsWeb) {
    messaging.onRegistered
        .listen((String installationId) {
          print('Firebase Installation ID (FID): $installationId');
          firebaseInstallationID = installationId;
        })
        .onError((err) {
          print('Error getting Firebase Installation ID: $err');
        });
    await messaging.register(
      vapidKey: "BEfe0Y4f84mk24QOgcVfbqCunLyG7Y20p8nPgjURHvMX1o8h1Uceue9H3ptIbQQLHSiB1FLyIYhW3bEGJzQYJ-Q",
    );
  } else {
    messaging.onRegistered
        .listen((String installationId) {
          print('Firebase Installation ID (FID): $installationId');
          firebaseInstallationID = installationId;
        })
        .onError((err) {
          print('Error getting Firebase Installation ID: $err');
        });
    await messaging.register();
  }
```
Here we're passing the `vapidKey` in the case of **Web**.

```
print("Firebase Installation ID: $firebaseInstallaationID");
```
9. Create the listener for messages while the app is open:
```dart
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Handling a foreground message: ${message.messageId}');
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
    ... // Do whatever you need to do with this message
  });
```
10. Create the function that checks messages that were received while the app is closed:
```dart
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
```
and create the function `_firebaseMessagingBackgroundHandler` above `main()`
```dart
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
  print('Message notification: ${message.notification?.body}');
}
```
> Note here we call `Firebase.initializeApp()` because when a message is received while the App is closed, in order to process it, Firebase needs to be initialized. Also note the `@pragma('vm:entry-point')` instruction. This is just so that in AOT compilation the compiler doesn't discard this part as **dead code**.


## Additional Configuration for Flutter Web
Flutter Web requires a service worker. This file is placed in the [Web](/web/) folder of the project [firebase-messaging-sw.js](/web/firebase-messaging-sw.js).
```javascript

importScripts("https://www.gstatic.com/firebasejs/11.6.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/11.6.1/firebase-messaging-compat.js");

const firebaseConfig = {
   apiKey: 'api-key',
   authDomain: 'project-id.firebaseapp.com',
   projectId: 'project-id',
   storageBucket: 'project-id.appspot.com',
   messagingSenderId: 'sender-id',
   appId: 'app-id',
   measurementId: 'G-measurement-id',
 };

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// todo Set up background message handler
messaging.onBackgroundMessage((message) => {
 console.log("onBackgroundMessage", message);
});
```




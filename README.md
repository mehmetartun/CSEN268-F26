# Lecture 14 - 07 - Accessing Database With Cloud Functinos

On the cloud functions `index.js` we add two functions
```javascript
const { initializeApp } = require("firebase-admin/app")
const { getFirestore } = require("firebase-admin/firestore")
initializeApp();

 exports.addData = onCall(async (request) => {
    var collection = request.data['collection'];
    var map = request.data['map'];
    var documentReference = await getFirestore().collection(collection).add(map);
    return { 'path': documentReference.path, 'id': documentReference.id };
});

exports.getData = onCall(async (request) => {
    var path = request.data['path'];
    var result = await getFirestore().doc(path).get();
    return { 'data': result.data() };
});
```
It uses the `firebase-admin/app` for initalization and `firebase-admin/firestore` for the Firestore database.

In the `addData` and `getData` functions we make an entry and retrieve a path.

On the Flutter app these are achieved:
```dart
  final HttpsCallable addDataCall = FirebaseFunctions.instance.httpsCallable(
    'addData',
  );
  final HttpsCallable getDataCall = FirebaseFunctions.instance.httpsCallable(
    'getData',
  );
  ```
  where we define the `HttpsCallable` and then call them through a button click:
  ```dart
    FilledButton(
              child: Text("Add Data"),
              onPressed: () async {
                HttpsCallableResult result = await addDataCall.call({
                  'collection': 'function_test',
                  'map': {
                    'firstName': 'John',
                    'lastName': 'Doe',
                    'class': 'CSEN F26',
                    'today': 'nice weather',
                  },
                });

                snack(result.data['path']);
                path = result.data['path'];
              },
            ),
            FilledButton(
              child: Text("Get Data"),
              onPressed: () async {
                HttpsCallableResult result = await getDataCall.call({
                  'path': path,
                });
                snack(result.data['data']['firstName']);
              },
            ),
```




# Lecture 15 -  Event Triggers

In this section we implemented the event trigger due to Firestore database document creation. We need to import:
```javascript
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
```
in order to use this function.

Setting up the trigger is done first by creating this function and then deploying it.
```javascript
exports.onUserCreated = onDocumentCreated("/function_test/{userId}" , async (event)=>{
  await getFirestore().collection('log_test').add(
    {
      'userId':event.params.userId,
      'createTime':event.data.createTime,
    }
  )
});
```
This matches any document with a path `/function_test/{userId}` and whenever a document with this pattern is created, it triggers this function. In turn we can act on this data. The `userId` in the **pattern** `"/function_test/{userId}"` is  a property of the `event.params` object.

# Deploying
When first time deploying triggered function you may get this error:
```zsh
⚠  functions: Since this is your first time using 2nd gen functions, we need a little bit longer to finish setting everything up. Retry the deployment in a few minutes.
⚠  functions:  failed to create function projects/csen268-f25/locations/us-central1/functions/onUserCreated
Failed to create function projects/csen268-f25/locations/us-central1/functions/onUserCreated
```
Just follow the instructions and wait for a few minutes before deploying again.

## Adding Cars to the Users
To add a `cars` collection to each user we have the `StreamBuilder` for all entries in the collection `function_test` and next to each entry we have a button to add a car:
```dart
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: FirebaseFirestore.instance
        .collection('function_test')
        .snapshots(),
    builder:
        (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.hasData) {
            return SizedBox(
              width: 400,
              child: ListView(
                shrinkWrap: true,
                children:
                    snapshot.data?.docs.map((doc) {
                      return ListTile(
                        title: Text(doc.data()['firstName'] ?? "N/A"),
                        subtitle: Text(doc.id),
                        trailing: IconButton(
                          icon: Icon(Icons.directions_car),
                          onPressed: () async {
                            String?
                            carName = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: Text(
                                    "Select Car Brand To Add to User",
                                  ),
                                  children: CarBrands.values.map((
                                    value,
                                  ) {
                                    return SimpleDialogOption(
                                      child: Text(value.name),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(value.name);
                                      },
                                    );
                                  }).toList(),
                                );
                              },
                            );
                            if (carName != null) {
                              await FirebaseFirestore.instance
                                  .collection('function_test')
                                  .doc(doc.id)
                                  .collection('cars')
                                  .add({'model': carName});
                            }
                          },
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            );
          }
          return CircularProgressIndicator();
        },
  ),
```
Now the `CollectionGroupQuery` can be made:
```dart
 FilledButton(
    child: Text("Do CollectionGroupQuery (toyota)"),
    onPressed: () async {
      try {
        var res = await FirebaseFirestore.instance
            .collectionGroup('cars')
            .where('model', isEqualTo: 'toyota')
            .get();

        print(res.docs.length);
      } catch (e) {
        print(e);
      }
    },
  ),
```

## Create the index for the Collection Group Query
When we first run this, we will encounter the following error:
```bash
[cloud_firestore/failed-precondition] The query requires a COLLECTION_GROUP_ASC index for collection cars and field model. You can create it here: https://console.firebase.google.com/v1/r/project/csen268-f25/firestore/indexes?create_exemption=Cktwcm9qZWN0cy9jc2VuMjY4LWYyNS9kYXRhYmFzZXMvKGRlZmF1bHQpL2NvbGxlY3Rpb25Hcm91cHMvY2Fycy9maWVsZHMvbW9kZWwQAhoJCgVtb2RlbBAB
```
If you follow this link you can create the appropriate index.

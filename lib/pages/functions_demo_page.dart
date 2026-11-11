import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:material_ui/material_ui.dart';

enum CarBrands { bmw, mercedes, toyota, chevy }

class FunctionsDemoPage extends StatefulWidget {
  const FunctionsDemoPage({super.key});

  @override
  State<FunctionsDemoPage> createState() => _FunctionsDemoPageState();
}

class _FunctionsDemoPageState extends State<FunctionsDemoPage> {
  String? path;
  void snack(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  final HttpsCallable helloWorldCall = FirebaseFunctions.instance.httpsCallable(
    'helloWorldCall',
  );
  final HttpsCallable addDataCall = FirebaseFunctions.instance.httpsCallable(
    'addData',
  );
  final HttpsCallable getDataCall = FirebaseFunctions.instance.httpsCallable(
    'getData',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Functions Demo")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              child: Text("Hello World"),
              onPressed: () async {
                HttpsCallableResult result = await helloWorldCall.call({});
                snack(result.data['message']);
              },
            ),
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
            FilledButton(
              child: Text("Do CollectionGroupQuery (mercedes)"),
              onPressed: () async {
                try {
                  var res = await FirebaseFirestore.instance
                      .collectionGroup('cars')
                      .where('model', isEqualTo: 'mercedes')
                      .get();

                  print(res.docs.length);
                } catch (e) {
                  print(e);
                }
              },
            ),
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
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:material_ui/material_ui.dart';

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
      body: Center(
        child: Column(
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
              child: Text("Do CollectionGroupQuery"),
              onPressed: () async {
                try {
                  var res = await FirebaseFirestore.instance
                      .collectionGroup('cars')
                      .where('model', isEqualTo: 'Toyota')
                      .get();

                  print(res.docs.length);
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

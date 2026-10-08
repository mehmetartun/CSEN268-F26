import 'package:flutter/material.dart';

import '../model/user.dart';
import '../widgets/tappable.dart';

class ListViewExamplePage extends StatelessWidget {
  const ListViewExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Example')),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          User user = User.createMockUser();
          return ListTile(
            title: Text("${user.firstName} ${user.lastName}"),
            subtitle: Text(user.email),
           
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

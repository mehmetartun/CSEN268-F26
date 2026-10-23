import 'package:flutter/material.dart';

class NoPermissionView extends StatelessWidget {
  const NoPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Center(child: Text("No Permission to see Contacts")),
    );
  }
}

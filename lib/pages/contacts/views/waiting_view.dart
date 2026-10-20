import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Center(
        child: Column(
          children: [
            Text("Saving the Contact"),
            Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

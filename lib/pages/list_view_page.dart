import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List View Page'), centerTitle: true),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

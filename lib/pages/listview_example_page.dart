import 'package:flutter/material.dart';

import '../widgets/tappable.dart';

class ListViewExamplePage extends StatelessWidget {
  const ListViewExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Example')),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
          Tappable(color: Colors.amber),
          Tappable(),
          Tappable(color: Colors.grey),
        ],
      ),
    );
  }
}

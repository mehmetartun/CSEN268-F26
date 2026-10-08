import 'package:flutter/material.dart';

import '../widgets/tappable.dart';

class SingleChildScrollViewAndListViewErrorExamplePage extends StatelessWidget {
  const SingleChildScrollViewAndListViewErrorExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleChildScrollView and ListView Error Example'),
      ),
      body: SingleChildScrollView(
        child: ListView(
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
      ),
    );
  }
}

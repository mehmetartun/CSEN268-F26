import 'package:flutter/material.dart';

import '../widgets/tappable.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Page')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Tappable(color: Colors.amber),
            ),
            Padding(padding: EdgeInsets.all(8.0), child: Tappable()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Tappable(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

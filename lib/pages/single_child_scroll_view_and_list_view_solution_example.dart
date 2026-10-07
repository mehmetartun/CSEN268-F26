import 'package:flutter/material.dart';

import '../widgets/tappable.dart';

class SingleChildScrollViewAndListViewSolutionExamplePage
    extends StatelessWidget {
  const SingleChildScrollViewAndListViewSolutionExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleChildScrollView and ListViewExample'),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
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

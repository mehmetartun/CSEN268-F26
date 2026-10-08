import 'package:material_ui/material_ui.dart';

import '../widgets/tappable.dart';

class SingleChildScrollViewExamplePage extends StatelessWidget {
  const SingleChildScrollViewExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SingleChildScrollView Example')),
      body: SingleChildScrollView(
        child: Column(
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

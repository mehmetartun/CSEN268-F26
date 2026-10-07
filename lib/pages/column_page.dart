import 'package:flutter/material.dart';

class ColumnPage extends StatelessWidget {
  const ColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Column Page'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Settings Clicked")));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.yellow,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 500,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("First Item"),
              ),
              Container(
                height: 500,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Second\nItem\n..."),
              ),
              Container(
                height: 500,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Third Item"),
              ),
              Container(
                height: 500,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

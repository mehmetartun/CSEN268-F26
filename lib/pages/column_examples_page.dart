import 'package:flutter/material.dart';

import '../widgets/tappable.dart';

class ColumnExamplesPage extends StatelessWidget {
  const ColumnExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column Examples')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "In the below examples, grey indicates the size "
                "of the available space meaning the size of the "
                "container, and yellow indicates the size of the Column itself",
              ),
              SizedBox(height: 20),
              Text("Column in a space of 300 height, MainAxisSize.min is set"),
              Container(
                height: 300,
                color: Colors.grey[400],
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Column in a space of 300 height, MainAxisSize.min is not set, MainAxisAlignment.spaceEvenly is set",
              ),
              Container(
                height: 300,
                color: Colors.grey[400],
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Column in a space of 300 height, MainAxisSize.min is not set, MainAxisAlignment.spaceAround is set",
              ),
              Container(
                height: 300,
                color: Colors.grey[400],
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Column in a space of 300 height, MainAxisSize.min is not set, MainAxisAlignment.spaceBetween is set",
              ),
              Container(
                height: 300,
                color: Colors.grey[400],
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Column in a space of no definitive height, MainAxisSize.min is set",
              ),
              Container(
                color: Colors.grey[400],
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Column in a space of no definitive height and infinite width, MainAxisSize.min is set.",
              ),
              Container(
                color: Colors.grey[400],
                width: double.infinity,
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Column in a space of no definitive height and infinite width, MainAxisSize.min is set, CrossAxisAlignment.start is set",
              ),
              Container(
                color: Colors.grey[400],
                width: double.infinity,
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.amber[200],
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tappable(color: Colors.amber),
                      Tappable(),
                      Tappable(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

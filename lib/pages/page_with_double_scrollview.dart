import 'package:flutter/material.dart';

class PageWithDoubleScrollview extends StatelessWidget {
  const PageWithDoubleScrollview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Double Scrollview Page'),
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
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("First Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primary,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  child: Row(
                    children: [
                      Text(
                        "Horizontal 1",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Horizontal 2",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Horizontal 3",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Horizontal 3",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Horizontal 3",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Horizontal 3",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Third Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text("Fourth Item"),
              ),
              Container(
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

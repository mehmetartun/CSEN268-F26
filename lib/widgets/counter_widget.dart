import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = 0;
  }

  void incrementNumber() {
    counter++;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.amber,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Counter: $counter"),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                incrementNumber();
              });
            },
          ),
        ],
      ),
    );
  }
}

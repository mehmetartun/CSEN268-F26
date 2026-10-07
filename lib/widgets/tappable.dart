import 'package:flutter/material.dart';

class Tappable extends StatefulWidget {
  const Tappable({super.key, this.color});
  final Color? color;

  @override
  State<Tappable> createState() => _TappableState();
}

class _TappableState extends State<Tappable> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color ?? Colors.green,
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _incrementCounter();
        },
        child: Text(
          'Tappable Widget: $_counter',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

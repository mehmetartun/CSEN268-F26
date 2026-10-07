# Lecture 5 - 01 

In this lecture we explored `StatefulWidget` and `StatelessWidget` along with the understanding of the main structure of a Flutter app.

## Directory Structure

A good way of organizing directory is to create separate folders under your `lib` directory for pages, widgets, services, etc. as
```zsh
    lib
    ├── main.dart
    ├── pages
    │   ├── example_page.dart
    │   └── home_page.dart
    ├── services
    └── widgets
        └── tappable.dart
```

## MaterialApp

The `MaterialApp` is the widget organizing routes, theme, etc. Here we have:
```dart
MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const ExamplePage(),
    )
```
where the `Theme` is specified by a color scheme from a seed color and the `home` property specifies the widget where the app starts. 

## StatefulWidget example Tappable

We created `Tappable` as a `StatefulWidget` to re-use within the code. The widget keeps it's own state and each instance is separate from other instances.

```dart
import 'package:flutter/material.dart';

class Tappable extends StatefulWidget {
  const Tappable({super.key, this.color});
  final Color? color;

  @override
  State<Tappable> createState() => _TappableState();
}
```
Here the widget takes a **nullable** variable `color` as an input. The UI element is created by `createState()` method and is an **internal** widget `_TappableState`.

```dart
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
```
Here the `_incrementCounter()` method makes the UI to rebuild by calling `setState()`. The argument of the `setState()` is a function which needs to be run **before** the UI is to be rebuilt. In this case it's just updating the value of the `_counter` variable.

On the UI front the visible UI element is a `Container` which has a `GestureDetector` as a child. This means when a `child` of the `GestureDetector` is tapped, the `onTap()` method is called. In this case it's calling `_incrementCounter()`.

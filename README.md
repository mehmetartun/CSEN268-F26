
# Lecture 11-03 - Updating the Drawer

```dart
class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
         ...
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BrightnessSelector(),
          ),
         ...
        ],
      ),
    );
  }
}

```


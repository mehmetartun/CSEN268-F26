# Lecture 18 - 1 Flutter Testing
In this lecture we will explore testing of widgets and the app in general

# Packages
Add the following:
```zsh
flutter pub add dev:test 'dev:flutter_driver:{"sdk":"flutter"}' 'dev:integration_test:{"sdk":"flutter"}'
```
with `dev_dependency` meaning it's a development dependency included in **development** mode. They are not included in the **release** mode,.

# Basic Test of the App
A basic test is shown in the [widget_test.dart](/test/widget_test.dart). 
```dart
import 'package:csen268/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Generic Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MySimpleApp());
    expect(find.text('Generic Page Test'), findsOneWidget);
    expect(find.textContaining('Generic'), findsOneWidget);
  });
}
```
Note that `MySimpleApp()` is just a widget that contains a `MaterialApp` in it's most basic form.
```dart
class MySimpleApp extends StatelessWidget {
  const MySimpleApp({super.key});

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'Simple App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GenericPage(title: 'Generic Page Test'),
    );
  }
}
```

To run this test we can either:
```zsh
flutter test test/widget_test.dart
```
or
```zsh
flutter run test/widget_test.dart
```

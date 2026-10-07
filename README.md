# CSEN268 - F26 - Lecture 5 - 01

## Theme

We implement theme from **Figma Material Theme Builder**. To cycle through the different options **light**, **dark**, etc. we first define a new class `MaterialTheme` which is implemented as:
```dart
class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00696f),
    ...
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }
}
```

To create the `TextTheme` we use **Google Fonts** by using the `google_fonts` package:
```dart
TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
```

We then use this to instantiate `MaterialTheme`:
```dart
 MaterialTheme materialTheme = MaterialTheme(
      createTextTheme(context, 'Roboto', 'Playfair Display'),
    );
```

In the `MaterialApp` we pass on the `ThemeData` by supplying the `light`, `dark` values coming from the `MaterialTheme`:
```dart
  return MaterialApp(
      ...
      theme: materialTheme.light(),
    );
```


## Counter Widget
The `CounterWidget` is a self contained `StatefulWidget`. When the widget changes due to user interaction, the parent does **not** get rebuilt!

## MyHomePage 
The `MyHomePage` contains a counter and is itself a `StatefulWidget`. It will rebuild **only** if the `FloatingActionButton` is tapped and `setState()` is triggered. Interaction with the `CounterWidget` does not cause rebuilds.

## PageWithDoubleScrollview
This widget demonstrates a nested horizontal and vertical `SingleChildScrollView` widget.

## ListViewPage
This is a basic widget for listing items.

## ColumnPage
Use of `Column`
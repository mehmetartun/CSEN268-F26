
# Lecture 11 - Theme

In this lecture we look at implementing a theme.

```
flutter pub add google_fonts
```
To add support for **Google Fonts**

## Inserting Theme into Material App

The download from Figma is `theme.dart` which can be placed in the `theme` folder:

```zsh
theme
├── cubit
│   ├── theme_cubit.dart
│   └── theme_state.dart
├── theme.dart
└── util.dart
```
The cubit will help us switch theme in the app.

The `theme.dart` file contains a class `MaterialTheme` which contains all variations of the theme in terms of **dark** and **light**. The text theme is created with `createTextTheme()` utility.

```dart
    MaterialTheme materialTheme = MaterialTheme(
      createTextTheme(context, 'Roboto', 'Roboto Condensed'),
    );
```

We then populate Material App parameters with the various theme modes.

```dart
    MaterialApp.router(
      title: 'CSEN 268 Fall 2025',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      highContrastDarkTheme: materialTheme.darkHighContrast(),
      highContrastTheme: materialTheme.lightHighContrast(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    ),
```





import "package:material_ui/material_ui.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff39608f),
      surfaceTint: Color(0xff39608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd3e4ff),
      onPrimaryContainer: Color(0xff1d4875),
      secondary: Color(0xff545f70),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd7e3f8),
      onSecondaryContainer: Color(0xff3c4858),
      tertiary: Color(0xff6c5677),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff4d9ff),
      onTertiaryContainer: Color(0xff533f5f),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff43474e),
      outline: Color(0xff73777f),
      outlineVariant: Color(0xffc3c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa2c9fe),
      primaryFixed: Color(0xffd3e4ff),
      onPrimaryFixed: Color(0xff001c38),
      primaryFixedDim: Color(0xffa2c9fe),
      onPrimaryFixedVariant: Color(0xff1d4875),
      secondaryFixed: Color(0xffd7e3f8),
      onSecondaryFixed: Color(0xff101c2b),
      secondaryFixedDim: Color(0xffbbc7db),
      onSecondaryFixedVariant: Color(0xff3c4858),
      tertiaryFixed: Color(0xfff4d9ff),
      onTertiaryFixed: Color(0xff261431),
      tertiaryFixedDim: Color(0xffd8bde3),
      onTertiaryFixedVariant: Color(0xff533f5f),
      surfaceDim: Color(0xffd8dae0),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fa),
      surfaceContainer: Color(0xffecedf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe1e2e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff023764),
      surfaceTint: Color(0xff39608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff486f9f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b3747),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff626e7f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff422f4d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7b6587),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff0e1116),
      onSurfaceVariant: Color(0xff32363d),
      outline: Color(0xff4e535a),
      outlineVariant: Color(0xff696d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa2c9fe),
      primaryFixed: Color(0xff486f9f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2e5784),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff626e7f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a5666),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7b6587),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff624d6d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c6cc),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fa),
      surfaceContainer: Color(0xffe7e8ee),
      surfaceContainerHigh: Color(0xffdbdce3),
      surfaceContainerHighest: Color(0xffd0d1d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002d54),
      surfaceTint: Color(0xff39608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff204b78),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff212d3c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3e4a5a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff372542),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff564161),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282c33),
      outlineVariant: Color(0xff454951),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa2c9fe),
      primaryFixed: Color(0xff204b78),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00345f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3e4a5a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff283343),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff564161),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3e2b49),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb7b8bf),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff0f7),
      surfaceContainer: Color(0xffe1e2e8),
      surfaceContainerHigh: Color(0xffd3d4da),
      surfaceContainerHighest: Color(0xffc5c6cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa2c9fe),
      surfaceTint: Color(0xffa2c9fe),
      onPrimary: Color(0xff00315b),
      primaryContainer: Color(0xff1d4875),
      onPrimaryContainer: Color(0xffd3e4ff),
      secondary: Color(0xffbbc7db),
      onSecondary: Color(0xff263141),
      secondaryContainer: Color(0xff3c4858),
      onSecondaryContainer: Color(0xffd7e3f8),
      tertiary: Color(0xffd8bde3),
      onTertiary: Color(0xff3c2947),
      tertiaryContainer: Color(0xff533f5f),
      onTertiaryContainer: Color(0xfff4d9ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111418),
      onSurface: Color(0xffe1e2e8),
      onSurfaceVariant: Color(0xffc3c6cf),
      outline: Color(0xff8d9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e8),
      inversePrimary: Color(0xff39608f),
      primaryFixed: Color(0xffd3e4ff),
      onPrimaryFixed: Color(0xff001c38),
      primaryFixedDim: Color(0xffa2c9fe),
      onPrimaryFixedVariant: Color(0xff1d4875),
      secondaryFixed: Color(0xffd7e3f8),
      onSecondaryFixed: Color(0xff101c2b),
      secondaryFixedDim: Color(0xffbbc7db),
      onSecondaryFixedVariant: Color(0xff3c4858),
      tertiaryFixed: Color(0xfff4d9ff),
      onTertiaryFixed: Color(0xff261431),
      tertiaryFixedDim: Color(0xffd8bde3),
      onTertiaryFixedVariant: Color(0xff533f5f),
      surfaceDim: Color(0xff111418),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0b0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff272a2f),
      surfaceContainerHighest: Color(0xff32353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc8deff),
      surfaceTint: Color(0xffa2c9fe),
      onPrimary: Color(0xff002749),
      primaryContainer: Color(0xff6d93c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd1ddf2),
      onSecondary: Color(0xff1b2635),
      secondaryContainer: Color(0xff8691a4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffefd3fa),
      onTertiary: Color(0xff311e3b),
      tertiaryContainer: Color(0xffa088ac),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9dce5),
      outline: Color(0xffaeb2ba),
      outlineVariant: Color(0xff8d9099),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e8),
      inversePrimary: Color(0xff1f4a77),
      primaryFixed: Color(0xffd3e4ff),
      onPrimaryFixed: Color(0xff001226),
      primaryFixedDim: Color(0xffa2c9fe),
      onPrimaryFixedVariant: Color(0xff023764),
      secondaryFixed: Color(0xffd7e3f8),
      onSecondaryFixed: Color(0xff061220),
      secondaryFixedDim: Color(0xffbbc7db),
      onSecondaryFixedVariant: Color(0xff2b3747),
      tertiaryFixed: Color(0xfff4d9ff),
      onTertiaryFixed: Color(0xff1b0926),
      tertiaryFixedDim: Color(0xffd8bde3),
      onTertiaryFixedVariant: Color(0xff422f4d),
      surfaceDim: Color(0xff111418),
      surfaceBright: Color(0xff42444a),
      surfaceContainerLowest: Color(0xff05070b),
      surfaceContainerLow: Color(0xff1b1e22),
      surfaceContainer: Color(0xff25282d),
      surfaceContainerHigh: Color(0xff303338),
      surfaceContainerHighest: Color(0xff3b3e43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe9f0ff),
      surfaceTint: Color(0xffa2c9fe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9fc5fa),
      onPrimaryContainer: Color(0xff000c1c),
      secondary: Color(0xffe9f0ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb7c3d7),
      onSecondaryContainer: Color(0xff020c1a),
      tertiary: Color(0xfffbebff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd4b9df),
      onTertiaryContainer: Color(0xff14041f),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff111418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf0f9),
      outlineVariant: Color(0xffbfc3cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e8),
      inversePrimary: Color(0xff1f4a77),
      primaryFixed: Color(0xffd3e4ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa2c9fe),
      onPrimaryFixedVariant: Color(0xff001226),
      secondaryFixed: Color(0xffd7e3f8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbbc7db),
      onSecondaryFixedVariant: Color(0xff061220),
      tertiaryFixed: Color(0xfff4d9ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd8bde3),
      onTertiaryFixedVariant: Color(0xff1b0926),
      surfaceDim: Color(0xff111418),
      surfaceBright: Color(0xff4e5055),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d2024),
      surfaceContainer: Color(0xff2e3035),
      surfaceContainerHigh: Color(0xff393b40),
      surfaceContainerHighest: Color(0xff44474c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}


# Lecture 11-02 - Theme Switching

To make it possible to swtich the theme we first instantiate the `ThemeCubit` and wrap the `MaterialApp` in a `BlocBuilder<ThemeCubit>` structure:

```dart
  final themeCubit = ThemeCubit();
  ..
    return MultiRepositoryProvider(
      ...
      child: MultiBlocProvider(
        providers: [
          ...
          BlocProvider(create: (context) => themeCubit),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'CSEN 268 Fall 2025',
              theme: materialTheme.light(),
              darkTheme: materialTheme.dark(),
              highContrastDarkTheme: materialTheme.darkHighContrast(),
              highContrastTheme: materialTheme.lightHighContrast(),
              themeMode: state.themeMode, // Changes the theme mode
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          },
        ),
```

## Brightness Widget

The last thing to do is to create a widget that is able to access the `ThemeCubit` and change the `mode` of the theme. The row of icon buttons are wrapped with a `BlocBuilder` to show the current state of the theme and the `cubit.changeThemeMode()` is called to change the mode.

```dart
class BrightnessSelector extends StatelessWidget {
  const BrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit cubit = BlocProvider.of<ThemeCubit>(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            state.themeMode == ThemeMode.light
                ? IconButton.filled(
                    icon: const Icon(Icons.light_mode),
                    onPressed: () {},
                  )
                : IconButton.filledTonal(
                    icon: const Icon(Icons.light_mode),
                    onPressed: () {
                      cubit.changeThemeMode(ThemeMode.light);
                      ...
                      Navigator.of(context).pop();
                    },
                  ),
              ... 
          ],
        );
      },
    );
  }
}
```
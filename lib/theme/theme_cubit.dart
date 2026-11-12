import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));
  ThemeMode themeMode = ThemeMode.system;
  late SharedPreferences prefs;

  void init() async {
    prefs = await SharedPreferences.getInstance();
    String themeModePreference = prefs.getString('themeMode') ?? 'system';
    switch (themeModePreference) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
    }
    emit(ThemeState(themeMode: themeMode));
  }

  void changeThemeMode(ThemeMode mode) {
    themeMode = mode;
    prefs.setString('themeMode', mode.name);
    emit(ThemeState(themeMode: themeMode));
  }
}

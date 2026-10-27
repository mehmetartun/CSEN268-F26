import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));
  ThemeMode themeMode = ThemeMode.system;

  void changeThemeMode(ThemeMode mode) {
    themeMode = mode;
    emit(ThemeState(themeMode: themeMode));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/cubit/theme_cubit.dart';

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
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Switched to light mode"),
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },

                    // isSelected: true,
                  ),
            const SizedBox(width: 10),
            state.themeMode == ThemeMode.dark
                ? IconButton.filled(
                    icon: const Icon(Icons.dark_mode),
                    onPressed: () {},
                  )
                : IconButton.filledTonal(
                    icon: const Icon(Icons.dark_mode),
                    onPressed: () {
                      cubit.changeThemeMode(ThemeMode.dark);
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Switched to dark mode"),
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },

                    // isSelected: true,
                  ),
            const SizedBox(width: 10),
            state.themeMode == ThemeMode.system
                ? IconButton.filled(
                    icon: const Icon(Icons.smartphone),
                    onPressed: () {},
                  )
                : IconButton.filledTonal(
                    icon: const Icon(Icons.smartphone),
                    onPressed: () {
                      cubit.changeThemeMode(ThemeMode.system);
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Switched to system mode"),
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },

                    // isSelected: true,
                  ),
          ],
        );
      },
    );
  }
}

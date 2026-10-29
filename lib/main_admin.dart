import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'firebase_options.dart';
import 'navigation/router.dart';
import 'pages/generic_page.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'theme/theme.dart';
import 'theme/theme_cubit.dart';
import 'theme/theme_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authenticationRepository =
        FirebaseAuthenticationRepository() as AuthenticationRepository;
    final authenticationBloc = AuthenticationBloc(authenticationRepository);
    final themeCubit = ThemeCubit();

    MaterialTheme materialTheme = MaterialTheme(
      createTextTheme(context, 'Roboto', 'Roboto Serif'),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authenticationRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => authenticationBloc),
          BlocProvider(create: (context) => themeCubit),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'CSEN 268 Fall 2026',
              theme: materialTheme.light(),
              darkTheme: materialTheme.dark(),
              highContrastDarkTheme: materialTheme.darkHighContrast(),
              highContrastTheme: materialTheme.lightHighContrast(),
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              home: GenericPage(title: "Welcome to Admin"),
            );
          },
        ),
      ),
    );
  }
}

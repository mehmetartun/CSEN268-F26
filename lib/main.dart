import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'firebase_options.dart';
import 'navigation/router.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'theme/theme.dart';
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

    MaterialTheme materialTheme = MaterialTheme(
      createTextTheme(context, 'Roboto', 'Roboto Serif'),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authenticationRepository),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => authenticationBloc)],
        child: MaterialApp.router(
          title: 'CSEN 268 Fall 2026',
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          highContrastDarkTheme: materialTheme.darkHighContrast(),
          highContrastTheme: materialTheme.lightHighContrast(),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}

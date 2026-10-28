import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/notifications/notifications_bloc.dart';
import 'firebase_options.dart';
import 'navigation/router.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'theme/theme.dart';
import 'theme/theme_cubit.dart';
import 'theme/theme_util.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
  print('Message notification: ${message.notification?.body}');
}

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
          BlocProvider(create: (context) => NotificationsBloc()..init()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'CSEN 268 Fall 2026',
              theme: materialTheme.light(),
              darkTheme: materialTheme.dark(),
              highContrastDarkTheme: materialTheme.darkHighContrast(),
              highContrastTheme: materialTheme.lightHighContrast(),
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                Widget _child = child ?? Container();
                return BlocListener<NotificationsBloc, NotificationsState>(
                  listener: (context, state) async {
                    if (state is NotificationsReceivedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.message.notification?.title ?? "<title>",
                              ),
                              Text(
                                state.message.notification?.body ?? "<body>",
                              ),
                              Text("Type: ${state.notificationType.name}"),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: _child,
                );
              },
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}

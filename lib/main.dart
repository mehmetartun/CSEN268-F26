import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'firebase_options.dart';
import 'navigation/router.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'theme/theme.dart';
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
  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  String? firebaseInstallationID;

  if (kIsWeb) {
    messaging.onRegistered
        .listen((String installationId) {
          print('Firebase Installation ID (FID): $installationId');
          // TODO: Send this FID to your application server
          firebaseInstallationID = installationId;
        })
        .onError((err) {
          print('Error getting Firebase Installation ID: $err');
        });
    await messaging.register(
      vapidKey: "BEfe0Y4f84mk24QOgcVfbqCunLyG7Y20p8nPgjURHvMX1o8h1Uceue9H3ptIbQQLHSiB1FLyIYhW3bEGJzQYJ-Q",
    );
  } else {
    messaging.onRegistered
        .listen((String installationId) {
          print('Firebase Installation ID (FID): $installationId');
          // TODO: Send this FID to your application server
          firebaseInstallationID = installationId;
        })
        .onError((err) {
          print('Error getting Firebase Installation ID: $err');
        });
    await messaging.register();
    // firebaseInstallationID = await FirebaseInstallations.instance.getId();
  }

  print("Firebase Installation ID: $firebaseInstallationID");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Handling a foreground message: ${message.messageId}');
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
    // Do whatever you need to do with this message
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

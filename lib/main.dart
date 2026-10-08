import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'navigation/routerdemo.dart';
import 'pages/home_page.dart';
import 'pages/login/login_page.dart';
import 'repositories/authentication/authentication_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authenticationRepository =
        OktaAuthenticationRepository() as AuthenticationRepository;
    final authenticationBloc = AuthenticationBloc(authenticationRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authenticationRepository),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => authenticationBloc)],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: routerDemo(authenticationBloc),
        ),
      ),
    );
  }
}

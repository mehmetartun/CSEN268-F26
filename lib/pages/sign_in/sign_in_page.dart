import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../navigation/my_navigator_route.dart';
import 'views/authenticated_view.dart';
import 'views/email_password_view.dart';
import 'views/error_view.dart';
import 'views/loading_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          context.goNamed(MyNavigatorRoute.home.name);
        }
      },
      builder: (context, state) {
        switch (state) {
          case AuthenticationAuthenticated _:
            return AuthenticatedView();
          case AuthenticationWaiting _:
            return LoadingView();
          case AuthenticationError _:
            return ErrorView(
              error: state.errorText,

              tryAgain: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationSignOutEvent());
              },
            );
          case AuthenticationInitial _:
            return EmailPasswordView(
              signInWithEmail: ({required email, required password}) {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationWithEmailEvent(
                    email: email,
                    password: password,
                  ),
                );
              },
            );
        }
      },
    );
  }
}

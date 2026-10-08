import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import 'views/sign_in_email_password_view.dart';
import 'views/sign_in_error_view.dart';
import 'views/sign_in_signed_in_view.dart';
import 'views/sign_in_waiting_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(
      context,
    );

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state) {
          case AuthenticationInitial _:
            return SignInEmailPasswordView();
          case AuthenticationAuthenticated _:
            return SignInSignedInView();
          case AuthenticationError _:
            return SignInErrorView(error: state.errorText);
          case AuthenticationWaiting():
            return SignInWaitingView();
        }
      },
    );
  }
}

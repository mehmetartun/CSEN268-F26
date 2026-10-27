import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../navigation/my_navigator_route.dart';
import 'views/authenticated_view.dart';
import 'views/email_password_view.dart';
import 'views/error_view.dart';
import 'views/loading_view.dart';
import 'views/new_user_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        await Future.delayed(Duration(seconds: 3), () {});
        if (state is AuthenticationAuthenticated) {
          context.goNamed(MyNavigatorRoute.home.name);
        }
      },
      builder: (context, state) {
        switch (state) {
          case AuthenticationNewUser _:
            return NewUserView(
              newUserWithEmail: ({required email, required password}) {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationNewUserEvent(email: email, password: password),
                );
              },
            );
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
              newUserRequest: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationNewUserRequestEvent());
              },
            );
        }
      },
    );
  }
}

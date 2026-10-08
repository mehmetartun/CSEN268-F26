import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';
import 'views/email_password_view.dart';
import 'views/error_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state) {
            case LoginInitial _:
              return EmailPasswordView();
            case LoginError _:
              return ErrorView();
          }
        },
      ),
    );
  }
}

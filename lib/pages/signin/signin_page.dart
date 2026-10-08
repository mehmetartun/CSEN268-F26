import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signin/views/email_password_view.dart';
import '../signin/views/error_view.dart';
import 'cubit/signin_cubit.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: BlocBuilder<SigninCubit, SigninState>(
        builder: (context, state) {
          switch (state) {
            case SigninInitial _:
            case SigninEmailPassword _:
              return const EmailPasswordView();
            case SigninError _:
              return ErrorView(message: state.message);
          }
        },
      ),
    );
  }
}

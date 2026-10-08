import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/authentication/authentication_repository.dart';
import '../signin/views/email_password_view.dart';
import 'cubit/login_cubit.dart';
import 'views/error_view.dart';
import 'views/success_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(RepositoryProvider.of<AuthenticationRepository>(context)),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state) {
            case LoginInitial _:
              return EmailPasswordView();
            case LoginError _:
              return ErrorView();
            case LoginSuccess _:
              return SuccessView();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication_bloc.dart';

class SignInErrorView extends StatelessWidget {
  const SignInErrorView({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(
      context,
    );
    return Scaffold(
      appBar: AppBar(title: Text("Sign In Error")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).colorScheme.errorContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("An error occured during sign in:"),
              const SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                child: Text("Try Again"),
                onPressed: () {
                  authenticationBloc.add(AuthenticationSignOutEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

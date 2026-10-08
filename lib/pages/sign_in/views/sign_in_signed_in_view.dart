import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication_bloc.dart';

class SignInSignedInView extends StatelessWidget {
  const SignInSignedInView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(
      context,
    );
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You Are Signed In!'),
            SizedBox(height: 20),
            FilledButton(
              child: Text("Sign Out"),
              onPressed: () {
                authenticationBloc.add(AuthenticationSignOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}

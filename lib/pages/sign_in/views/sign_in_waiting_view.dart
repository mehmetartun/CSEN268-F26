import 'package:flutter/material.dart';

class SignInWaitingView extends StatelessWidget {
  const SignInWaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const CircularProgressIndicator()],
        ),
      ),
    );
  }
}

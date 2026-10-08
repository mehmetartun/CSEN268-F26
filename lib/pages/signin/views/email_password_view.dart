import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/signin_cubit.dart';

class EmailPasswordView extends StatelessWidget {
  const EmailPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Password View")),
      body: Center(
        child: FilledButton(
          child: Text("Signin"),
          onPressed: () {
            BlocProvider.of<SigninCubit>(context).signin();
          },
        ),
      ),
    );
  }
}

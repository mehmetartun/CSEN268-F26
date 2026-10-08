import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';

class EmailPasswordView extends StatelessWidget {
  const EmailPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(child: Column(
        children: [
          Text("Login Please"),
          FilledButton(
            child: Text("Login"),
            onPressed: (){
              BlocProvider.of<LoginCubit>(context).login();
            },
          ),
        ],
      )),
    );
  }
}

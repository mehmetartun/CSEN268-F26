import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';

class EmailPasswordView extends StatefulWidget {
  const EmailPasswordView({super.key});

  @override
  State<EmailPasswordView> createState() => _EmailPasswordViewState();
}

class _EmailPasswordViewState extends State<EmailPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Login Please"),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(label: Text("Email")),
                  onSaved: (val) {
                    email = val;
                  },
                  validator: (val) {
                    if (val == null || val.trim() == "") {
                      return "Email must not be empty";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(label: Text("Password")),
                  onSaved: (val) {
                    password = val;
                  },
                  validator: (val) {
                    if (val == null || val.trim() == "") {
                      return "Password must not be empty";
                    }
                    return null;
                  },
                ),
                FilledButton(
                  child: Text("Login"),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      BlocProvider.of<LoginCubit>(context).login(email: email!, password: password!);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

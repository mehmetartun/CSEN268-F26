import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication_bloc.dart';

class SignInEmailPasswordView extends StatefulWidget {
  const SignInEmailPasswordView({super.key});

  @override
  State<SignInEmailPasswordView> createState() =>
      _SignInEmailPasswordViewState();
}

class _SignInEmailPasswordViewState extends State<SignInEmailPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    // TODO: implement initState
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
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
      appBar: AppBar(title: Text("SignIn Page")),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("SignIn Please"),
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
                SizedBox(height: 10),
                Text("Hint: giving value 'password' will cause an error"),
                SizedBox(height: 10),
                FilledButton(
                  child: Text("Login"),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      authenticationBloc.add(
                        AuthenticationWithEmailEvent(
                          email: email!,
                          password: password!,
                        ),
                      );
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

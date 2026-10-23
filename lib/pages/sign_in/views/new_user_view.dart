import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewUserView extends StatefulWidget {
  const NewUserView({super.key, required this.newUserWithEmail});
  final void Function({required String email, required String password})
  newUserWithEmail;

  @override
  State<NewUserView> createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
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
      appBar: AppBar(title: Text("New User Page")),
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
                      widget.newUserWithEmail(
                        email: email!,
                        password: password!,
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

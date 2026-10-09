import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../widgets/print_route.dart';

class RouterDemoLogin extends StatelessWidget {
  const RouterDemoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              PrintRoute(),
              Text(
                "User is not logged in. Clicking the button will "
                "log the user in by adding an AuthenticationWithEmailEvent "
                "to the AuthenticationBloc",
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: FilledButton(
                  child: Text("Login"),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationWithEmailEvent(
                        email: "email",
                        password: "apassword",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

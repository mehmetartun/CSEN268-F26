import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../navigation/routerdemo.dart';
import '../../widgets/print_route.dart';

class RouterDemoProfile extends StatelessWidget {
  const RouterDemoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              PrintRoute(),
              Text("Router Demo Profile"),
              Container(
                width: double.infinity,
                child: FilledButton(
                  child: Text("Logout"),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(
                      context,
                    ).add(AuthenticationSignOutEvent());
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  child: Text("Show Detail"),
                  onPressed: () {
                    context.goNamed(RouteName.profileDetail);
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

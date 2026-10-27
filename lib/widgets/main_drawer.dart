import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../navigation/my_navigator_route.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              children: [
                Text(
                  'Main Drawer',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (BlocProvider.of<AuthenticationBloc>(context).user != null)
                  Text(BlocProvider.of<AuthenticationBloc>(context).user!.uid),
              ],
            ),
          ),
          ListTile(
            title: const Text('Images'),
            onTap: () {
              context.pop();
              context.goNamed(MyNavigatorRoute.images.name);
            },
          ),
          ListTile(
            title: const Text('Map'),
            onTap: () {
              context.pop();
              context.goNamed(MyNavigatorRoute.map.name);
            },
          ),
          ListTile(
            title: const Text('Contacts'),
            onTap: () {
              context.pop();
              context.goNamed(MyNavigatorRoute.contacts.name);
            },
          ),
          ListTile(
            title: const Text('Database'),
            onTap: () {
              context.pop();
              context.goNamed(MyNavigatorRoute.database.name);
            },
          ),
          ListTile(
            title: const Text('SignIn'),
            onTap: () {
              context.pop();
              context.goNamed(MyNavigatorRoute.signIn.name);
            },
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: FilledButton(
              child: Text("Sign out"),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationSignOutEvent());
              },
            ),
          ),
        ],
      ),
    );
  }
}

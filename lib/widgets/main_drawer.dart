import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

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
            child: Text(
              'Main Drawer',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ListTile(
            title: const Text('Images'),
            onTap: () {
              context.goNamed(MyNavigatorRoute.images.name);
            },
          ),
          ListTile(
            title: const Text('Map'),
            onTap: () {
              context.goNamed(MyNavigatorRoute.map.name);
            },
          ),
        ],
      ),
    );
  }
}

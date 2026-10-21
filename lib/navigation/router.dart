import 'package:go_router/go_router.dart';

import '../pages/contacts/contacts_page.dart';
import '../pages/generic_page.dart';
import '../pages/image_page.dart';
import '../pages/map_page.dart';
import 'my_navigator_route.dart';

final GoRouter router = GoRouter(
  initialLocation: MyNavigatorRoute.home.path,
  routes: [
    GoRoute(
      path: MyNavigatorRoute.home.path,
      name: MyNavigatorRoute.home.name,
      builder: (context, state) => GenericPage(title: "Home"),
      routes: [
        GoRoute(
          path: MyNavigatorRoute.images.path,
          name: MyNavigatorRoute.images.name,
          builder: (context, state) => ImagePage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.map.path,
          name: MyNavigatorRoute.map.name,
          builder: (context, state) => MapPage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.contacts.path,
          name: MyNavigatorRoute.contacts.name,
          builder: (context, state) => ContactsPage(),
        ),
      ],
    ),
  ],
);

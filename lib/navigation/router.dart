import 'package:csen268f26/pages/future_builder_page.dart';
import 'package:csen268f26/pages/shimmer_future_builder_page.dart';
import 'package:csen268f26/pages/stream_builder_page.dart';
import 'package:go_router/go_router.dart';

import '../pages/alert_page.dart';
import '../pages/contacts/contacts_page.dart';
import '../pages/database/database_page.dart';
import '../pages/generic_page.dart';
import '../pages/image_page.dart';
import '../pages/map_page.dart';
import '../pages/sign_in/sign_in_page.dart';
import '../pages/web_view_page.dart';
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
        GoRoute(
          path: MyNavigatorRoute.database.path,
          name: MyNavigatorRoute.database.name,
          builder: (context, state) => DatabasePage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.signIn.path,
          name: MyNavigatorRoute.signIn.name,
          builder: (context, state) => SignInPage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.dialogs.path,
          name: MyNavigatorRoute.dialogs.name,
          builder: (context, state) => AlertPage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.futureBuilder.path,
          name: MyNavigatorRoute.futureBuilder.name,
          builder: (context, state) => FutureBuilderPage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.streamBuilder.path,
          name: MyNavigatorRoute.streamBuilder.name,
          builder: (context, state) => StreamBuilderPage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.shimmer.path,
          name: MyNavigatorRoute.shimmer.name,
          builder: (context, state) => ShimmerFutureBuilderPage(),
        ),
        GoRoute(
          path: MyNavigatorRoute.webView.path,
          name: MyNavigatorRoute.webView.name,
          builder: (context, state) => WebViewPage(),
        ),
      ],
    ),
  ],
);

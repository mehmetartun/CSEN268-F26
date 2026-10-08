import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../pages/router_demo/router_demo_home.dart';
import '../pages/router_demo/router_demo_login.dart';
import '../pages/router_demo/router_demo_profile.dart';
import '../pages/router_demo/router_demo_profile_detail.dart';
import '../pages/router_demo/router_demo_users.dart';
import '../utilities/stream_to_listenable.dart';
import '../widgets/scaffold_with_nav_bar.dart';

class RouteName {
  static const home = "home";
  static const login = "login";
  static const profile = "profile";
  static const profileDetail = "profileDetail";
  static const users = "users";
  static const editprofile = "editprofile";
  static const adduser = "adduser";
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Root",
);
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Shell",
);

GoRouter routerDemo(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/users',
    refreshListenable: StreamToListenable([authenticationBloc.stream]),
    redirect: (context, state) async {
      if (authenticationBloc.state is AuthenticationInitial &&
          (!(state.fullPath?.startsWith("/login") ?? false))) {
        return "/login";
      } else {
        if ((state.fullPath?.startsWith("/login") ?? false) &&
            authenticationBloc.state is AuthenticationAuthenticated) {
          return "/users";
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) {
          return const RouterDemoLogin();
        },
      ),
      GoRoute(
        path: '/',
        name: RouteName.home,
        builder: (context, state) {
          return const RouterDemoHome();
        },
        routes: [
          ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return ScaffoldWithNavBar(child: child);
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'users',
                name: RouteName.users,
                builder: (BuildContext context, GoRouterState state) {
                  return const RouterDemoUsers();
                },
              ),
              GoRoute(
                path: 'profile',
                name: RouteName.profile,
                builder: (BuildContext context, GoRouterState state) {
                  return const RouterDemoProfile();
                },
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: RouteName.profileDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) {
                      return const RouterDemoProfileDetail();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

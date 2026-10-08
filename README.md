# Lecture 8 - 03

We start with the `GoRouter` implementation. We first do a cleanup of the repo and get rid of the Layout examples and the widget `Tappable`.

The objective is to achieve the following structure:

<img src="assets/images/Lecture 0801 Implementation Picture.png" width="600">

To do that we first inject an `AuthenticationBloc` into the tree above the `MaterialApp`

```dart
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authenticationBloc = AuthenticationBloc();
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return (OktaAuthenticationRepository() as AuthenticationRepository);
      },
      child: BlocProvider(
        create: (context) => authenticationBloc..add(AuthenticationLoginEvent()),
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ...
          routerConfig: routerDemo(authenticationBloc),
        ),
      ),
    );
  }
}
```
Here the `bloc` is injected **after** the `RepositoryProvider` as the the bloc will require the `AuthenticationRepository` to be able to do the signing in.

The `router` object is now defined together with a the `refreshListenable` and the `redirect` configurations to handle changes to the `AuthenticationState` and direct the routing accordingly. This is affected by:
```dart
GoRouter routerDemo(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/users',
    refreshListenable: StreamToListenable([authenticationBloc.stream]),
    redirect: (context, state) async {
      if (authenticationBloc.state is AuthenticationLoggedOut &&
          (!(state.fullPath?.startsWith("/login") ?? false))) {
        return "/login";
      } else {
        if ((state.fullPath?.startsWith("/login") ?? false) &&
            authenticationBloc.state is AuthenticationLoggedIn) {
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
}
```
The `ScaffoldWithNavBar` is a construct to allow the `ShellRoute` to have bottom navigation bottoms. It's defined in [ScaffoldWithNavBar](/lib/widgets/scaffold_with_nav_bar.dart).

In addition the `StreamToListenable` is defined in the [utilities](./lib/utilities) folder as [StreamToListenable](/lib/utilities/stream_to_listenable.dart) which takes a list of streams as argument and turns them to a combined listenable object that is then used to trigger `redirect` everytime the listenable receives an update.

An important item to note is the navigator keys that are being used. For the `profile detail` to be shown **without** the bottom navigation bar, we force the navigator of that page to be the `rootNavigator` rather then the `shellNavigator`. For this, we first create the keys:
```dart
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Root",
);
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Shell",
);
```
and inject them as follows in the `GoRouter` object:
```dart
GoRouter routerDemo(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/users',
    refreshListenable: StreamToListenable([authenticationBloc.stream]),
    redirect: (context, state) async {
        ...
    },
    routes: [
      GoRoute(
        path: '/login',
        ...
      ),
      GoRoute(
        path: '/',
        ...
        routes: [
          ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return ScaffoldWithNavBar(child: child);
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'users',
                ...
              ),
              GoRoute(
                path: 'profile',
                ...
                routes: [
                  GoRoute(
                    path: 'detail',
                    parentNavigatorKey: rootNavigatorKey,
                    ...
                  ),
}
```





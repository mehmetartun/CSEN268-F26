# Lecture 8 - 01

Here we implement the `BLoC` method of managing states.

## MultiBlocProvider

At the top of our code, before `MaterialApp` we place a `MultiBlocProvider` which will act as the `AuthenticationBloc`. 

```dart
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              FirebaseAuthenticationRepository() as AuthenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthenticationBloc())],
        child: MaterialApp(...)
```
where we also changed the `RepositoryProvider` to a `MultiRepositoryProvider` to be able to attach other repositories in the future.

##  Page to use the AuthenticationBloc

We create a new page `SignInPage` which will use the `AuthenticationBloc`. This page creates a reference to the `AuthenticationBloc` via:
```dart
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(
      context,
    );
```
The rest of the flow will be implemented in the next phase. The `SignInPage` has a `BlocBuilder` which listens to the states of the `AuthenticationBloc`
```dart 
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state) {
          default:
            return SignInWaitingView();
        }
      },
    );
```
and currently we simply show a waiting view as the `default` case of the `switch`.



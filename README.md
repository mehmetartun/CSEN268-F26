# Lecture 8 - 02

We continue with our **BLoC** implmentation. First we create the necessary states for authentication

## Authentication States

```dart
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationError extends AuthenticationState {
  final String errorText;

  AuthenticationError({required this.errorText});
}

final class AuthenticationWaiting extends AuthenticationState {}

final class AuthenticationAuthenticated extends AuthenticationState {}
```

The `AuthenticationInitial` state is a proxy for unauthenticated state. 

> Note: It's possible (and useful) sometimes to distinguish between **unknown** and **unauthenticated** states.

## Authentication Events

The events that we will need to send to the `AuthenticationBloc` are:

```dart 
sealed class AuthenticationEvent {}

class AuthenticationWithEmailEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationWithEmailEvent({required this.email, required this.password});
}

class AuthenticationErrorEvent extends AuthenticationEvent {
  final String errorText;
  AuthenticationErrorEvent({required this.errorText});
}

class AuthenticationSignOutEvent extends AuthenticationEvent {} 
```

## Authentication Repository

To handle the flow, we implement a `signOut()` method as well as an error to the `signIn()` method to simulate the error:

```dart
  @override
  Future<User> signIn({required String email, required String password}) async {
    await someFirebaseSpecificMethod();
    if (password == "password") {
      throw Exception("Invalid password");
    }
    return User.createMockUser();
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }
```
In the `signIn()` method we throw an `Exception` whenever the value of the `password` is simply **password**. 

## Event Handler within the AuthenticationBloc

The events received by the `AuthenticationBloc` are handled with the following code in the constructor:
```dart
  AuthenticationBloc(this.authenticationRepository)
    : super(AuthenticationInitial()) {
    on<AuthenticationWithEmailEvent>((event, emit) async {
      await _handleLogin(event, emit);
    });
    on<AuthenticationErrorEvent>((event, emit) {
      _handleError(event, emit);
    });
    on<AuthenticationSignOutEvent>((event, emit) async {
      await _handleSignOut(event, emit);
    });
  }
```
Note here that two of these handlers are asynchronous and therefore they need to be awaited.

## SignInPage

Finally, the `SignInPage` has displays the views based on the state of AuthenticationBloc.
```dart
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state) {
          case AuthenticationInitial _:
            return SignInEmailPasswordView();
          case AuthenticationAuthenticated _:
            return SignInSignedInView();
          case AuthenticationError _:
            return SignInErrorView(error: state.errorText);
          case AuthenticationWaiting():
            return SignInWaitingView();
        }
      },
    );
```


## Behaviour of the SignIn Page

<img src="./assets/gifs/Lect0802_video.gif" width="300"/>
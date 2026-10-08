# Lecture 6 - 02

We now move to the **BLoC** pattern. Here we implement a very simple login flow using a **cubit** from the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package.

## The Login Cubit
The login page is created by `LoginPage` as a stateless widget. The function of this widget is to 
1. Instantiate an appropriate cubit `LoginCubit`
2. Show different views depending on the state of the cubit, i.e. `LoginState`.

```dart
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: ...
    );
  }
}
```

Note that `LoginState` is an abstract class created with the keyword `sealed` meaning it can only be extended in this file but nowhere else:
```dart
sealed class LoginState {}
```

Then we can crate different states based on this abstract class:
```dart
final class LoginInitial extends LoginState {}
final class LoginError extends LoginState {}
```

## Directory
The typical directory structure for a page with a cubit is as follows:
```zsh
lib/pages/login
├── cubit
│   ├── login_cubit.dart
│   └── login_state.dart
├── login_page.dart
└── views
    ├── email_password_view.dart
    └── error_view.dart
```

## The methods in the cubit
The cubit initially emits a state called `LoginInitial` through the constructor:
```dart
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(){
    emit(LoginError());
  }
}
```
 This is then used to display the `EmailPasswordView` by the `LoginPage` widget:
 ```dart
 BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state) {
            case LoginInitial _:
              return EmailPasswordView();
            ...
          }
        },
      ),
 ```

 ## Accessing methods of the cubit

 In the `EmailPasswordView` we have a button that calls the `login()` method in the cubit:
 ```dart
      FilledButton(
      child: Text("Login"),
      onPressed: (){
        BlocProvider.of<LoginCubit>(context).login();
      },
    ),
```
Here we access the cubit with the construct `BlocProvider.of<LoginCubit>(context)`. When this method is called, it emits an `LoginError()` state which is then captured by the `BlocBuilder` to display the `ErrorView`.

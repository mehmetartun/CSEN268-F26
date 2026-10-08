# Lecture 7 - 03

## Error Handling

We look at error handling in the authentication flow by throwing an **Exception** in the authentication repository:
```dart
class FirebaseAuthenticationRepository extends AuthenticationRepository {
  ...
  Future<User> signIn({required String email, required String password}) async {
    ...
    if (password == "TopSecret") {
      return User.createMockUser();
    } else {
      throw Exception("Wrong password");
    }
  }
}
```
We can catch this error with the `try` and `catch` keywords in the `cubit`:
```dart
Future<void> login({required String email, required String password}) async {
    try {
      user = await authenticationRepository.signIn(
        email: email,
        password: password,
      );
      if (user == null) {
        emit(LoginError(message: "User is null..."));
        return;
      }
      emit(LoginSuccess());
      return;
    } catch (e) {
      emit(LoginError(message: e.toString()));
      return;
    }
  }
```

## Removing dependency to cubit from views
One of the important design methods is to make sure your views are unrelated to your implementation. Therefore when we show an error message we pass the error message to the error view :
```dart
class LoginPage extends StatelessWidget {
  ...
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(RepositoryProvider.of<AuthenticationRepository>(context)),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state) {
            ...
            case LoginError _:
              return ErrorView(message: state.message);          
            ...  
          }}}}
```

and for the **login** function we pass the function as a parameter:
```dart
            case LoginInitial _:
              return EmailPasswordView(
                onLogin: BlocProvider.of<LoginCubit>(context).login,
              );
```
with the usage in the `EmailPasswordView` defined as:
```dart
class EmailPasswordView extends StatefulWidget {
  const EmailPasswordView({super.key, required this.onLogin});
  final Future<void> Function({required String email, required String password})
  onLogin;
...
}

class _EmailPasswordViewState extends State<EmailPasswordView> {
  ...

  void loginUser() async {
    ...
    widget.onLogin(email: email!, password: password!);
   ...

  @override
  Widget build(BuildContext context) {
    ...
  }}
```


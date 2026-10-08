# Lecture 7 - 02

To evaluate the **Repository Pattern** we crate a  abstract class `AuthenticationRepository`:
```dart
abstract class AuthenticationRepository {
  Future<User> signIn({required String email, required String password});
}
```

and create two separate implementations `FirebaseAuthenticationRepository` and `OktaAuthenticationRepository`. These both extend the abstract class `AuthenticationRepository`

```dart
class FirebaseAuthenticationRepository extends AuthenticationRepository {
  Future<void> someFirebaseSpecificMethod() async {
    await Future.delayed(const Duration(seconds: 10), () {});
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    await someFirebaseSpecificMethod();
    return User.createMockUser();
  }
}
```
The key here is that the abstract class specifies a method `signIn` which needs to be implemented by both repositories.

## Login Cubit

The injection of the `AuthenticationRepository` to the `LoginCubit` is done via the constructor:
```dart
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitial());
  User? user;
  final AuthenticationRepository authenticationRepository;
  ...
}
```
where the `User` variable is necessary to hold the return value from the `signIn` method.

When the `LoginCubit` is created in the `LoginPage` the `AuthenticationRepository` from the widget tree is injected as:
```dart
    return BlocProvider(
      create: (context) => LoginCubit(RepositoryProvider.of<AuthenticationRepository>(context)),
      child: BlocBuilder<LoginCubit, LoginState>(...)
```

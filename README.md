
# Lecture 10 - Part 3 - Firebase Authentication

## New User 

To sign up new user we use the function `createUserWithEmailAndPassword`

```dart
 Future<void> _handleNewUser(event, emit) async {
    emit(AuthenticationWaiting());
    try {
      user = await authenticationRepository.newUser(
        email: event.email,
        password: event.password,
      );

      emit(AuthenticationAuthenticated());
      return;
    } catch (e) {
      emit(AuthenticationError(errorText: e.toString()));
      print(e);
    }
  }
```
which is handled by the `AuthenticationBloc` via the `_handleNewUser` method that in turn calls the `AuthenticationRepository` method `newUser`.

The `newUser` method in the `AuthenticationRepository` is the actual implementation of the `FirebaseAuth` method `createNewUserWithEmailAndPassword`.

```dart
@override
  Future<User> newUser({
    required String email,
    required String password,
  }) async {
    auth.UserCredential userCredential = await auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user == null) {
      throw Exception("User is null");
    }
    return User(
      email: userCredential.user!.email ?? "",
      uid: userCredential.user!.uid,
      firstName: userCredential.user!.displayName ?? "",
      lastName: userCredential.user!.displayName ?? "",
      imageUrl: userCredential.user!.photoURL ?? "",
    );
  }
```




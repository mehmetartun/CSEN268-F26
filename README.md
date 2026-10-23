
### Lecture 10 - Part 2 - Firebase Authentication

For firebase authentication we modify the `FirebaseAuthenticationRepository` to connect to Firebase Authentication.

```dart
class FirebaseAuthenticationRepository extends AuthenticationRepository {

  @override
  Future<User> signIn({required String email, required String password}) async {
    auth.UserCredential userCredential = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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

  @override
  Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}
```

The the `signIn` page then handles the authentication.


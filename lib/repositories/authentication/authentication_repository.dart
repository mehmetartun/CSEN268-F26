import '../../model/user.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthenticationRepository {
  Future<User> signIn({required String email, required String password});
  Future<void> signOut();
}

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  Future<void> someFirebaseSpecificMethod() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }

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

class OktaAuthenticationRepository extends AuthenticationRepository {
  Future<void> someOktaSpecificMethod() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    print("Attempting to sign in with Okta");
    await someOktaSpecificMethod();
    if (password == "password") {
      throw Exception("Invalid password");
    }
    print("Successfully signed in with Okta");
    return User.createMockUser();
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }
}

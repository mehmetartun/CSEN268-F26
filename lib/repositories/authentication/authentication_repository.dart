import '../../model/user.dart';

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

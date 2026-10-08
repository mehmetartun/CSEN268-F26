import '../../model/user.dart';

abstract class AuthenticationRepository {
  Future<User> signIn({required String email, required String password});
}

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  Future<void> someFirebaseSpecificMethod() async {
    await Future.delayed(const Duration(seconds: 3), () {});
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    await someFirebaseSpecificMethod();
    if (password == "TopSecret") {
      return User.createMockUser();
    } else {
      throw Exception("Wrong password");
    }
  }
}

class OktaAuthenticationRepository extends AuthenticationRepository {
  Future<void> someOktaSpecificMethod() async {
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    await someOktaSpecificMethod();
    return User.createMockUser();
  }
}

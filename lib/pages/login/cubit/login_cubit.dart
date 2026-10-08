import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user.dart';
import '../../../repositories/authentication/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitial());
  User? user;

  final AuthenticationRepository authenticationRepository;

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
}

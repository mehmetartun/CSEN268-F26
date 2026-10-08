import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user.dart';
import '../../../repositories/authentication/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitial());
  User? user;

  final AuthenticationRepository authenticationRepository;

  void login({required String email, required String password}) async {
    user = await authenticationRepository.signIn(
      email: email,
      password: password,
    );
    if (user == null) {
      emit(LoginError());
      return;
    }
    emit(LoginSuccess());
  }
}

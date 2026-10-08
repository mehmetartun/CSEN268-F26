import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user.dart';
import '../../repositories/authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.authenticationRepository)
    : super(AuthenticationInitial()) {
    on<AuthenticationWithEmailEvent>((event, emit) async {
      await _handleLogin(event, emit);
    });
    on<AuthenticationErrorEvent>((event, emit) {
      _handleError(event, emit);
    });
    on<AuthenticationSignOutEvent>((event, emit) async {
      await _handleSignOut(event, emit);
    });
  }
  final AuthenticationRepository authenticationRepository;
  User? user;

  void init() async {}

  Future<void> _handleSignOut(event, emit) async {
    emit(AuthenticationWaiting());
    user = null;
    await authenticationRepository.signOut();
    emit(AuthenticationInitial());
  }

  void _handleError(event, emit) {
    emit(AuthenticationError(errorText: event.errorText));
  }

  Future<void> _handleLogin(event, emit) async {
    emit(AuthenticationWaiting());
    try {
      user = await authenticationRepository.signIn(
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
}

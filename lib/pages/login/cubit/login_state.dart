part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}

final class LoginSuccess extends LoginState {}

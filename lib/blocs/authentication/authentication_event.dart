part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

class AuthenticationWithEmailEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationWithEmailEvent({required this.email, required this.password});
}

class AuthenticationNewUserEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationNewUserEvent({required this.email, required this.password});
}

class AuthenticationErrorEvent extends AuthenticationEvent {
  final String errorText;
  AuthenticationErrorEvent({required this.errorText});
}

class AuthenticationSignOutEvent extends AuthenticationEvent {}

class AuthenticationNewUserRequestEvent extends AuthenticationEvent {}

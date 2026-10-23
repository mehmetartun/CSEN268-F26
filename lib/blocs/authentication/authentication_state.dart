part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationError extends AuthenticationState {
  final String errorText;

  AuthenticationError({required this.errorText});
}

final class AuthenticationWaiting extends AuthenticationState {}

final class AuthenticationAuthenticated extends AuthenticationState {}

final class AuthenticationNewUser extends AuthenticationState {}

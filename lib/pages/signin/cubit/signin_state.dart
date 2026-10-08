part of 'signin_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninEmailPassword extends SigninState {}

final class SigninError extends SigninState {
  final String message;

  SigninError({required this.message});
}

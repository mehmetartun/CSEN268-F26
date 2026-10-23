part of 'database_cubit.dart';

@immutable
sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}

final class DatabaseLoading extends DatabaseState {}

final class DatabaseLoaded extends DatabaseState {
  final List<User> users;

  DatabaseLoaded({required this.users});
}

final class DatabaseInsert extends DatabaseState {}

final class DatabaseError extends DatabaseState {
  final String error;

  DatabaseError({required this.error});
}

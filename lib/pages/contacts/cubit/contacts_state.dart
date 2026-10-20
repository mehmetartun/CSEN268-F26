part of 'contacts_cubit.dart';

sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsPermissionFullAccess extends ContactsState {
  ContactsPermissionFullAccess({required this.contacts});
  final List<Contact> contacts;
}

final class ContactsPermissionReadOnly extends ContactsState {
  ContactsPermissionReadOnly({required this.contacts});
  final List<Contact> contacts;
}

final class ContactsPermissionDenied extends ContactsState {}

final class WaitingState extends ContactsState {}

final class ContactEdit extends ContactsState {
  ContactEdit({required this.contact});
  final Contact contact;
}

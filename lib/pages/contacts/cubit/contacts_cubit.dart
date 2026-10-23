import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contacts_state.dart';

// enum PermissionType { readOnly, full, none }

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());

  // PermissionType permissionType = PermissionType.none;
  late PermissionStatus permissionStatus;
  List<Contact> contacts = [];

  void init() async {
    permissionStatus = await FlutterContacts.permissions.request(
      PermissionType.readWrite,
    );
    if (permissionStatus == PermissionStatus.granted ||
        permissionStatus == PermissionStatus.limited) {
      contacts = await FlutterContacts.getAll();
      emit(ContactsPermissionFullAccess(contacts: contacts));
      return;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await FlutterContacts.permissions.request(
        PermissionType.read,
      );
      if (permissionStatus == PermissionStatus.granted ||
          permissionStatus == PermissionStatus.limited) {
        contacts = await FlutterContacts.getAll();
        emit(ContactsPermissionReadOnly(contacts: contacts));
        return;
      }
    }

    emit(ContactsPermissionDenied());
  }

  void editContact(Contact contact) {
    emit(ContactEdit(contact: contact));
  }

  void saveContact(Contact contact) async {
    emit(WaitingState());
    await FlutterContacts.update(contact);
    emit(ContactsPermissionFullAccess(contacts: contacts));
  }
}

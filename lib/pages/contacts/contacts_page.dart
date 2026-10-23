import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/contacts_cubit.dart';
import 'views/contact_edit_view.dart';
import 'views/contacts_view.dart';
import 'views/no_permission_view.dart';
import 'views/waiting_view.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ContactsCubit cubit = ContactsCubit();

    return BlocProvider(
      create: (context) => cubit..init(),
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          switch (state) {
            case ContactsPermissionDenied _:
              return NoPermissionView();
            case ContactsPermissionFullAccess _:
              return ContactsView(
                contacts: state.contacts,
                readOnly: false,
                editContact: cubit.editContact,
              );
            case ContactsPermissionReadOnly _:
              return ContactsView(
                contacts: state.contacts,
                readOnly: true,
                editContact: cubit.editContact,
              );
            case ContactEdit _:
              return ContactEditView(
                contact: state.contact,
                saveContact: cubit.saveContact,
              );
            case WaitingState _:
              return WaitingView();
            default:
              return NoPermissionView();
          }
        },
      ),
    );
  }
}

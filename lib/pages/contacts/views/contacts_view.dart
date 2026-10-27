import 'package:material_ui/material_ui.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsView extends StatelessWidget {
  final List<Contact> contacts;
  final bool readOnly;
  final Function(Contact) editContact;
  const ContactsView({
    super.key,
    required this.contacts,
    required this.readOnly,
    required this.editContact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Column(
        children: [
          Text("Here are your contacts"),
          Expanded(
            child: ListView(
              children: contacts.map((contact) {
                return ListTile(
                  title: Text(contact.displayName ?? "--"),
                  trailing: readOnly
                      ? null
                      : IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editContact(contact);
                          },
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

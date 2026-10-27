import 'package:material_ui/material_ui.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactEditView extends StatefulWidget {
  final void Function(Contact) saveContact;
  final Contact contact;
  const ContactEditView({
    super.key,
    required this.saveContact,
    required this.contact,
  });

  @override
  State<ContactEditView> createState() => _ContactEditViewState();
}

class _ContactEditViewState extends State<ContactEditView> {
  GlobalKey<FormState> formKey = GlobalKey();
  late Contact _contact;

  @override
  void initState() {
    _contact = widget.contact;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Edit Contact Below"),
              TextFormField(
                decoration: InputDecoration(labelText: "First Name"),
                initialValue: _contact.name?.first,
                onSaved: (val) {
                  if (val != null) {
                    _contact.copyWith(
                      name: _contact.name == null
                          ? Name(first: val)
                          : _contact.name!.copyWith(first: val),
                    );
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Last Name"),
                initialValue: _contact.name?.last,
                onSaved: (val) {
                  if (val != null) {
                    _contact.copyWith(
                      name: _contact.name == null
                          ? Name(last: val)
                          : _contact.name!.copyWith(last: val),
                    );
                  }
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: "Display Name"),
              //   initialValue: _contact.displayName,
              //   onSaved: (val) {
              //     if (val != null) _contact.displayName = val;
              //   },
              // ),
              FilledButton(
                child: Text("Save"),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    print(_contact);
                    widget.saveContact(_contact);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

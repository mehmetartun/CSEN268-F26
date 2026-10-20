## Santa Clara University - CSEN268 Spring 2025

[Table of Contents](/toc.md)

### Lecture 9 - Part 3 - Flutter Contacts Implementation

In this part we add the following packages to the project
    flutter_contacts
by issuing `flutter pub add <packagename1> <packagename2> ...`

### Setting Permissions

In the [AndroidManifest.xml](/android/app/src/main/AndroidManifest.xml) we add:
```xml
    <uses-permission android:name="android.permission.READ_CONTACTS" />
    <uses-permission android:name="android.permission.WRITE_CONTACTS" />
```
and in the [Info.plist](/ios/Runner/Info.plist) we add:
```xml
	<key>NSContactsUsageDescription</key>
	<string>To facilitate sharing with your contacts, we require access to contacts on your device.</string>
```
### Contacts Cubit

In order to manage the contacts we create a `ContactsCubit` which will house all the methods we need and also the various states that go with the management and view of the contacts.

Out `ContactsPage` is going to act as the main entry point, spawning the cubit and then incorporating a `BlocBuilder` that returns different views depending on the state. The creation of the cubit also follows a call to the `init()` method of the cubit to fetch contacts and permissions.

```dart
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
            ...
          }}))}
```
and the associated states to switch between the views is affected by:
```dart
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
```
The initialization of the cubit follows with the `init()` method which retrieves the permissions and contact list:
```dart
  void init() async {
    if (await FlutterContacts.requestPermission()) {
      permissionType = PermissionType.full;
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      emit(ContactsPermissionFullAccess(contacts: contacts));
      return;
    } else {
      if (Platform.isAndroid) {
        if (await FlutterContacts.requestPermission(readonly: true)) {
          permissionType = PermissionType.readOnly;
          contacts = await FlutterContacts.getContacts();
          emit(ContactsPermissionReadOnly(contacts: contacts));
          return;
        }
      }
    }
    emit(ContactsPermissionDenied());
  }
```

Looking at each of the views, the `ContactsView` will display a list with either an **edit** button or without depending on whether we are in read only mode or not.
```dart
        ListView(
              children:
                  contacts.map((contact) {
                    return ListTile(
                      title: Text(contact.displayName),
                      trailing:
                          readOnly
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
```

<!-- <img src="/assets/images/Initial View of Contacts.png" width="300"> -->

Note that the `editContact()` function has to be passed on from the cubit. This is done in the switch statement in the `ContactsPage` widget which has access to the `ContactsCubit`. The view widgets do not have access to the `ContactsCubit`.

The other important view here is the `ContactEditView` which contains a form. This view is a `StatefulWidget` as it contains a `Form`. The `Contact` object is replicated to a local copy (local to the `State` of the `StatefulWidget`) and any changes are modified there. The provided `saveContact()` function is in reality the `saveContact()` method in the `ContactsCubit`. When the `Form` is submitted the `Contact` with modifications is sent to this method.

```dart
  void initState() {
    _contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "First Name"),
                initialValue: _contact.name.first,
                onSaved: (val) {
                  if (val != null) _contact.name.first = val;},
              ),
              TextFormField(),
              TextFormField(),
              FilledButton(
                child: Text("Save"),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    widget.saveContact(_contact);
                  }
                }
```

<!-- <img src="/assets/images/Contacts Edit Form.png" width="300"> -->

Inside the `ContactsCubit` the `saveContact` function first emits a `WaitingState` and then updates the contact and subsequently emits a state to view full list of the contacts.

```dart
  void saveContact(Contact contact) async {
    emit(WaitingState());
    await contact.update();
    emit(ContactsPermissionFullAccess(contacts: contacts));
  }
```

<!-- <img src="/assets/images/Contacts Edit Recording.gif" width="300"> -->


import 'package:flutter/material.dart';

import '../../../model/user.dart';

class InsertView extends StatefulWidget {
  final void Function(User) addUser;
  const InsertView({super.key, required this.addUser});

  @override
  State<InsertView> createState() => _InsertViewState();
}

class _InsertViewState extends State<InsertView> {
  @override
  Widget build(BuildContext context) {
    User mockUser = User.createMockUser();
    return Scaffold(
      appBar: AppBar(title: Text("Add User")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name", style: Theme.of(context).textTheme.labelMedium),
              Text(mockUser.firstName + " " + mockUser.lastName),
              SizedBox(height: 10),
              Text("Email", style: Theme.of(context).textTheme.labelMedium),
              Text(mockUser.email),
              SizedBox(height: 10),
              Text("Uid", style: Theme.of(context).textTheme.labelMedium),
              Text(mockUser.uid),
              SizedBox(height: 10),
              Text("ImageUrl", style: Theme.of(context).textTheme.labelMedium),
              Text(mockUser.imageUrl),
              SizedBox(height: 10),
              FilledButton(
                child: Text("Add User"),
                onPressed: () {
                  widget.addUser(mockUser);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

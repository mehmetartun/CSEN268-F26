import 'package:flutter/material.dart';

import '../../../model/user.dart';
import '../../../widgets/user_list_tile.dart';

class LoadedView extends StatelessWidget {
  final List<User> users;
  final void Function() addUserRequest;
  final void Function(User) deleteUser;
  const LoadedView({
    super.key,
    required this.users,
    required this.addUserRequest,
    required this.deleteUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        actions: [IconButton(onPressed: addUserRequest, icon: Icon(Icons.add))],
      ),
      body: ListView(
        children: users.map((user) {
          return UserListTile(
            user: user,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteUser(user);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:material_ui/material_ui.dart';

import 'model/user.dart';
import 'widgets/user_list_tile.dart';

void main() {
  runApp(const MyTestApp());
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: UserListTile(
          user: User(
            firstName: "John",
            lastName: "Doe",
            email: "john@doe.com",
            imageUrl: "https://placehold.co/500x500",
            uid: "1234567890",
          ),
        ),
      ),
    );
  }
}

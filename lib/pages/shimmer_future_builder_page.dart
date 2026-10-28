import 'package:material_ui/material_ui.dart';

import '../model/user.dart';
import '../widgets/shimmer_list_widget.dart';
import '../widgets/user_list_tile.dart';

Future<List<User>> getData() async {
  await Future.delayed(Duration(seconds: 3));
  List<User> users;
  users = List.generate(20, (index) {
    return User.createMockUser();
  });
  return users;
}

class ShimmerFutureBuilderPage extends StatelessWidget {
  const ShimmerFutureBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Future Builder Shimmer Demo")),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.data!.map((user) {
                  return UserListTile(user: user);
                }).toList(),
              );
            } else {
              return ShimmerListWidget();
            }
          },
        ),
      ),
    );
  }
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:csen268f26/model/user.dart';
import 'package:csen268f26/widgets/user_list_tile.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Widget createWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  testWidgets('UserListTile Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      createWidget(
        UserListTile(
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
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('JD'), findsOneWidget);
    expect(find.text('john@doe.com'), findsOneWidget);
    await tester.pumpWidget(
      createWidget(
        UserListTile(
          user: User(
            firstName: "John",
            lastName: "",
            email: "john@doe.com",
            imageUrl: "https://placehold.co/500x500",
            uid: "1234567890",
          ),
        ),
      ),
    );
    expect(find.text('John'), findsOneWidget);
    expect(find.text('J'), findsOneWidget);
    expect(find.text('john@doe.com'), findsOneWidget);
  });
}

import 'package:csen268f26/model/user.dart';
import 'package:csen268f26/widgets/user_list_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

// ... your other imports

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  Widget createUserList() {
    return ListView(
      children: List.generate(20, (index) {
        return UserListTile(
          user: User(
            firstName: "First$index",
            lastName: "Last$index",
            imageUrl: "https://placehold.co/400x400",
            email: "first$index@last$index.com",
            uid: "$index",
          ),
        );
      }),
    );
  }

  testWidgets('ListView', (tester) async {
    await tester.pumpWidget(createWidget(createUserList()));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOne);
    expect(find.text("First0 Last0"), findsOne);
    await tester.fling(find.byType(ListView), Offset(0, -200), 400);
    await tester.pumpAndSettle();
    expect(find.text("First0 Last0"), findsNothing);
    await tester.fling(find.byType(ListView), Offset(0, 200), 400);
    await tester.pumpAndSettle();
    expect(find.text("First0 Last0"), findsOne);
    await tester.tap(find.byType(UserListTile).first);
    await tester.pumpAndSettle();
    expect(find.text('First0 Last0 added.'), findsOne);
  });
}

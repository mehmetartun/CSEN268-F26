import 'package:csen268f26/firebase_options.dart';
import 'package:csen268f26/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  group('Testing MyApp', () {
    testWidgets('Firestore Test', (tester) async {
      await tester.pumpWidget(const MySimpleApp());
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      // expect(find.text('Testing Start'), findsOne);
      expect(find.text('Firestore Test'), findsOne);
      expect(find.widgetWithText(FilledButton, "Add Data"), findsOne);
      expect(find.widgetWithText(FilledButton, "Retrieve Data"), findsOne);
      await tester.tap(find.widgetWithText(FilledButton, "Add Data"));
      await tester.pumpAndSettle(Duration(milliseconds: 5000));
      expect(find.text("Data Added: true"), findsOne);
      await tester.tap(find.widgetWithText(FilledButton, "Retrieve Data"));
      await tester.pumpAndSettle(Duration(milliseconds: 5000));
      expect(find.text("Data Retrieved: true"), findsOne);
      expect(find.text("First Name: John"), findsOne);
    });
  });
}

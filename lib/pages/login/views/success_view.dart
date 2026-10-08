import 'package:material_ui/material_ui.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(child: Text("Success!")),
    );
  }
}

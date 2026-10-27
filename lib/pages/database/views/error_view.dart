import 'package:material_ui/material_ui.dart';

class ErrorView extends StatelessWidget {
  final String error;
  const ErrorView({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Database Error")),
      body: Text(error),
    );
  }
}

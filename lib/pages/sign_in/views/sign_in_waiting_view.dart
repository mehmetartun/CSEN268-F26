import 'package:material_ui/material_ui.dart';

class SignInWaitingView extends StatelessWidget {
  const SignInWaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text('Signing In...'),
          ],
        ),
      ),
    );
  }
}

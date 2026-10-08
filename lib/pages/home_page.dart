import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text(
                'Navigation',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ListTile(
              title: const Text('Login Page (Cubit)'),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/loginPage');
              },
            ),
            ListTile(
              title: const Text('SignIn Page (Bloc)'),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/signInPage');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Use the menu to navigate to different example pages"),
      ),
    );
  }
}

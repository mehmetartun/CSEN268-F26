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
              title: const Text('Column Examples'),
              onTap: () {
                Navigator.pushNamed(context, '/columnExamples');
              },
            ),
            ListTile(
              title: const Text('ListView Example'),
              onTap: () {
                Navigator.pushNamed(context, '/listViewExample');
              },
            ),
            ListTile(
              title: const Text('SingleChildScrollView Example'),
              onTap: () {
                Navigator.pushNamed(context, '/singleChildScrollViewExample');
              },
            ),
            ListTile(
              title: const Text(
                'SingleChildScrollView and ListView Error Example',
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/singleChildScrollViewAndListViewErrorExample',
                );
              },
            ),
            ListTile(
              title: const Text(
                'SingleChildScrollView and ListView Solution Example',
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/singleChildScrollViewAndListViewSolutionExample',
                );
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

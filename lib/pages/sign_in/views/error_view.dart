import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final void Function() tryAgain;
  const ErrorView({super.key, required this.error, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentication Error")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.errorContainer,
              child: Text(
                error,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
            SizedBox(height: 20),
            FilledButton(onPressed: tryAgain, child: Text("Try Again")),
          ],
        ),
      ),
    );
  }
}

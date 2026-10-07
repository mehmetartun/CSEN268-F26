import 'package:flutter/material.dart';

class LabeledTextWidget extends StatelessWidget {
  const LabeledTextWidget({super.key, required this.label, required this.text});
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/print_route.dart';

class RouterDemoProfileDetail extends StatelessWidget {
  const RouterDemoProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [PrintRoute(), Text("Profile Detail Page")]),
        ),
      ),
    );
  }
}

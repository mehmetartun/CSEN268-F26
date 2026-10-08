import 'package:flutter/material.dart';

import 'pages/column_examples_page.dart';
import 'pages/example_page.dart';
import 'pages/home_page.dart';
import 'pages/listview_example_page.dart';
import 'pages/single_child_scroll_view_and_list_view_error_page.dart';
import 'pages/single_child_scroll_view_and_list_view_solution_example.dart';
import 'pages/single_child_scroll_view_example_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const ExamplePage(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/columnExamples": (context) => const ColumnExamplesPage(),
        "/listViewExample": (context) => const ListViewExamplePage(),
        // "/centerExample": (context) => const CenterExamplePage(),
        "/singleChildScrollViewExample": (context) =>
            const SingleChildScrollViewExamplePage(),
        "/singleChildScrollViewAndListViewErrorExample": (context) =>
            const SingleChildScrollViewAndListViewErrorExamplePage(),
        "/singleChildScrollViewAndListViewSolutionExample": (context) =>
            const SingleChildScrollViewAndListViewSolutionExamplePage(),
      },
    );
  }
}

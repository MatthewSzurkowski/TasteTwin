import 'package:flutter/material.dart';
import 'package:taste_twin/pages/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taste Twin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Switch MyHomePage -> MatchPage to test
      home: const MyHomePage(title: 'Taste Twin'),
    );
  }
}

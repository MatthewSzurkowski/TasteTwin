import 'package:flutter/material.dart';
import 'package:taste_twin/pages/homepage.dart';
// import 'pages/homepage.dart';
// import 'pages/carousel_page.dart';
import 'pages/matchpage.dart';
import 'pages/settings.dart';
import 'pages/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taste Twin',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // Switch MyHomePage -> MatchPage to test
      home: const MatchPage(title: 'Taste Twin'),
    );
  }
}

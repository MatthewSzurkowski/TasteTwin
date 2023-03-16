import 'package:flutter/material.dart';
import 'package:taste_twin/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        primarySwatch: Colors.blue,
      ),
      // Switch MyHomePage -> MatchPage to test
      home: const MyHomePage(title: 'Taste Twin'),
    );
  }
}

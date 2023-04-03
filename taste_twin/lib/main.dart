import 'package:flutter/material.dart';
import 'package:taste_twin/pages/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/preferences_provider.dart';
import '/components/preferences.dart';
import '/components/userPreferences.dart';
import '/components/userPreferences_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, Preferences>(
        (ref) => PreferencesNotifier());

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
        (ref) => UserPreferencesNotifier());

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

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
    //final preferences = useProvider(preferencesProvider);
    return ProviderScope(
      child: MaterialApp(
        title: 'Taste Twin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Taste Twin'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taste_twin/pages/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/preferences_provider.dart';
import '/components/preferences.dart';
import '/components/userPreferences.dart';
import '/components/userPreferences_provider.dart';

//final preferencesProvider = Provider<Preferences>((ref) => preferences);

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, Preferences>(
        (ref) => PreferencesNotifier());

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
        (ref) => UserPreferencesNotifier());

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

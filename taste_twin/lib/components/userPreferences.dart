// ignore_for_file: file_names

import 'package:taste_twin/components/rest.dart';

class UserPreferences {
  int numUsers = 2;
  List<List<Rest>> matches;

  UserPreferences({
    required this.numUsers,
    required this.matches,
  });
}

final userPreferences = UserPreferences(
  numUsers: 2,
  matches: [],
);

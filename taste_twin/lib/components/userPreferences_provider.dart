import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/userPreferences.dart';
import 'rest.dart';

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier()
      : super(UserPreferences(
          numUsers: 2,
          matches: [],
        ));

  void addMatch(List<Rest> match) {
    state.matches.add(match);
  }
}

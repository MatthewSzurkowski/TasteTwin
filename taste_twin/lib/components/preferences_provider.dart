import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/preferences.dart';

class PreferencesNotifier extends StateNotifier<Preferences> {
  PreferencesNotifier()
      : super(Preferences(
          searchDistance: 10,
          showFastFood: true,
          time: "1",
          numUsers: 1,
          remUsers: 1,
          selectedCuisines: [
            'Italian',
            'Chinese',
            'Mexican',
            'Indian',
            'French',
            'Japanese',
            'American'
          ],
        ));

  void setSearchDistance(double newValue) {
    state.searchDistance = newValue;
  }

  double getSearchDistance() {
    return state.searchDistance;
  }

  void setFastFood(bool newValue) {
    state.showFastFood = newValue;
  }

  bool getFastFood() {
    return state.showFastFood;
  }

  String setTime(String value) {
    state.time = value;
    return state.time;
  }

  String getTime() {
    return state.time;
  }

  int getRemUsers() {
    return state.remUsers;
  }

  void decrementUsers() {
    state.remUsers -= 1;
  }

  void setSelectedCuisines(List<dynamic> values) {
    state.selectedCuisines = values;
  }

  List<dynamic> getSelectedCuisines() {
    return state.selectedCuisines;
  }

  int setNumUsers(int value) {
    state.remUsers = value;
    state.numUsers = value;
    return state.numUsers;
  }

  int getNumUsers() {
    return state.numUsers;
  }
}

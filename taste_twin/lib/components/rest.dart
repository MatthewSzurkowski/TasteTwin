import '../models/restaurant.dart';

class Rest {
  Restaurant? name = null;
  int time = 0;
  int numUsers = 1;
  String restaurantName = "";

  setRestaurant(Restaurant restaurant) {
    name = restaurant;
  }

  getRestaurant() {
    return name;
  }

  int getTime() {
    return time;
  }

  setTime(int time) {
    this.time = time;
  }

  addTime(int time) {
    this.time += time;
  }

  addUser() {
    numUsers++;
  }

  int getUsers() {
    return numUsers;
  }

  setName(String name) {
    restaurantName = name;
  }

  String getName() {
    return restaurantName;
  }
}

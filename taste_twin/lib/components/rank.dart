import 'rest.dart';

class Rank {
  Rest? rest;
  int numUsers;
  double time;

  Rank({
    required this.rest,
    required this.numUsers,
    required this.time,
  });

  int getUsers() {
    return numUsers;
  }

  void addUser() {
    numUsers += 1;
  }

  void setRestaurant(Rest? newRest) {
    rest = newRest;
  }

  Rest? getRestaurant() {
    return rest;
  }

  double getTime() {
    return time;
  }

  void addTime(double newTime) {
    time = time + newTime;
  }
}

final restObj = Rank(rest: null, numUsers: 0, time: 0);

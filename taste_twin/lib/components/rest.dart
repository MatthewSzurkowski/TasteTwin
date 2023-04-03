import '../models/restaurant.dart';

class Rest {
  Restaurant? rest;
  double time;

  Rest({
    required this.rest,
    required this.time,
  });

  double getTime() {
    return time;
  }

  void setTime(double newTime) {
    time = newTime;
  }

  void setRestaurant(Restaurant newRest) {
    rest = newRest;
  }

  Restaurant? getRestaurant() {
    return rest;
  }
}

final restObj = Rest(rest: null, time: 0);

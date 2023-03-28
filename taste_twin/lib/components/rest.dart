import '../models/restaurant.dart';

class Rest {
  Restaurant? restList = null;
  int time = 0;

  setRestaurant(Restaurant restaurant) {
    restList = restaurant;
  }

  getResaurant() {
    return restList;
  }

  int getTime() {
    return time;
  }

  setTime(int time) {
    this.time = time;
  }
}

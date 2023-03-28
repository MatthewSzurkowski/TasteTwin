import '../models/restaurant.dart';

class Rest {
  List<Restaurant>? tempRestaurantList = null;
  int time = 0;

  addRestaurant(Restaurant restaurant) {
    tempRestaurantList!.add(restaurant);
  }

  removeRestaurant(Restaurant restaurant) {
    tempRestaurantList!.remove(restaurant);
  }

  getResaurantList() {
    return tempRestaurantList;
  }

  int getTime() {
    return time;
  }

  setTime(int time) {
    this.time = time;
  }
}

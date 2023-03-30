class Preferences {
  double searchDistance;
  bool showFastFood;
  String time;
  int numUsers;
  List<dynamic> selectedCuisines = [
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'French',
    'Japanese',
    'American'
  ];

  Preferences({
    required this.searchDistance,
    required this.showFastFood,
    required this.time,
    required this.numUsers,
    required this.selectedCuisines,
  });
}

final preferences = Preferences(
  searchDistance: 10,
  showFastFood: true,
  time: "1",
  numUsers: 1,
  selectedCuisines: [
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'French',
    'Japanese',
    'American'
  ],
);

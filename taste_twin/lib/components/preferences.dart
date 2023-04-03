class Preferences {
  double searchDistance;
  bool showFastFood;
  String time;
  int numUsers;
  int remUsers;
  List<dynamic> selectedCuisines = [
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'Canadian',
    'Greek',
    'American'
  ];

  Preferences({
    required this.searchDistance,
    required this.showFastFood,
    required this.time,
    required this.numUsers,
    required this.remUsers,
    required this.selectedCuisines,
  });
}

final preferences = Preferences(
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
    'Canadian',
    'Greek',
    'American'
  ],
);

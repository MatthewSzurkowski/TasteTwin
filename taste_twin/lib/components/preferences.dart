class Preferences {
  double searchDistance;
  bool showFastFood;
  bool showItalian;
  bool showChinese;
  bool showMexican;
  bool showIndian;
  bool showFrench;
  bool showJapanese;
  bool showAmerican;
  int time;
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
    required this.showItalian,
    required this.showChinese,
    required this.showMexican,
    required this.showIndian,
    required this.showFrench,
    required this.showJapanese,
    required this.showAmerican,
    required this.time,
    required this.selectedCuisines,
  });
}

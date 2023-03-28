import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> list = <String>[
  "30 Seconds",
  "1 Minute",
  "2 Minutes",
  "3 Minutes",
  "4 Minutes",
  "5 Minutes"
];

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, Preferences>((ref) {
  // Create an instance of the Preferences class
  Preferences preferences = Preferences(
      searchDistance: 15,
      showAmerican: true,
      showChinese: true,
      showFastFood: true,
      showFrench: true,
      showIndian: true,
      showItalian: true,
      showJapanese: true,
      showMexican: true,
      time: 1,
      selectedCuisines: [
        'Italian',
        'Chinese',
        'Mexican',
        'Indian',
        'French',
        'Japanese',
        'American'
      ]);

  // Return a PreferencesNotifier with the created instance of Preferences
  return PreferencesNotifier(preferences);
});

class PreferencesNotifier extends StateNotifier<Preferences> {
  PreferencesNotifier(Preferences preferences) : super(preferences);

  // Create a method to set a variable in Preferences and update the state
  void setSearchDistance(double newValue) {
    state.searchDistance = newValue;
  }

  void setFastFood(bool newValue) {
    state.showFastFood = newValue;
  }

  void setSelectedCuisines(List<dynamic> values) {
    state.selectedCuisines = values;
  }

  List<String> get selectedCuisines {
    var chosenCuisines = <String>[];
    if (state.showItalian) {
      chosenCuisines.add("Italian");
    }
    if (state.showChinese) {
      chosenCuisines.add("Chinese");
    }
    if (state.showMexican) {
      chosenCuisines.add("Mexican");
    }
    if (state.showIndian) {
      chosenCuisines.add("Indian");
    }
    if (state.showFrench) {
      chosenCuisines.add("French");
    }
    if (state.showJapanese) {
      chosenCuisines.add("Japanese");
    }
    if (state.showAmerican) {
      chosenCuisines.add("American");
    }
    return chosenCuisines;
  }
}

class FiltersPage extends StatefulWidget {
  FiltersPage({super.key, required this.title, required String preferences});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FiltersPage> createState() => _FiltersPage();
}

class _FiltersPage extends State<FiltersPage> {
  // initial value for the slider
  bool showFastFood = true;
  String eachPersonTimeLimit = "1 minute";
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final notifier = ref.watch(preferencesProvider.notifier);
        final preferences = ref.watch(preferencesProvider);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text(
                  'Search Distance',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('0 km'),
                    Text('15 km'),
                  ],
                ),
                Slider(
                  value: preferences.searchDistance,
                  min: 0,
                  max: 15,
                  divisions: 3,
                  label: '${preferences.searchDistance} km',
                  onChanged: (double value) {
                    setState(() {
                      //_currentDistance = value;
                      notifier.setSearchDistance(value);
                    });
                  },
                ),
                Text('Current distance: ${preferences.searchDistance} km'),
                // Add more filters here
                const SizedBox(height: 20),
                const Center(
                    child: Text('Show Fast Food',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Switch.adaptive(
                    value: preferences.showFastFood,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Colors.blue,
                    thumbColor:
                        const MaterialStatePropertyAll<Color>(Colors.white),
                    onChanged: (bool value) {
                      //preferences.showFastFood = value;
                      setState(() {
                        //_currentDistance = value;
                        notifier.setFastFood(value);
                      });
                      // This is called when the user toggles the switch.
                      // setState(() {
                      //   showFastFood = value;
                      // });
                    },
                  ),
                ]),
                const SizedBox(height: 20),
                const Center(
                    child: Text(
                  'Restaurant Types',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                CustomCheckBoxGroup(
                  buttonTextStyle: const ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  autoWidth: false,
                  enableButtonWrap: true,
                  wrapAlignment: WrapAlignment.center,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: const [
                    "Italian",
                    "Chinese",
                    "Mexican",
                    "Indian",
                    "French",
                    "Japanese",
                    "American",
                  ],
                  buttonValuesList: const [
                    "Italian",
                    "Chinese",
                    "Mexican",
                    "Indian",
                    "French",
                    "Japanese",
                    "American",
                  ],
                  checkBoxButtonValues: (List<dynamic> values) {
                    // ignore: avoid_print
                    //print(values);
                    setState(() {
                      notifier.setSelectedCuisines(values);
                    });
                    //preferences.selectedCuisines = Set<bool>.from(values);
                  },
                  defaultSelected: preferences
                      .selectedCuisines, //preferences.selectedCuisines.toList(),
                  horizontal: false,
                  width: 120,
                  // hight: 50,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  padding: 5,
                  enableShape: true,
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                        child: Text('Time For Each Person',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(CupertinoIcons.time),
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );

    // body: const Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: Text("Filters Page")));
  }
}

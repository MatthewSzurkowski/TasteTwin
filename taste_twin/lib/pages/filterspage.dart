import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>[
  "30 Seconds",
  "1 Minute",
  "2 Minutes",
  "3 Minutes",
  "4 Minutes",
  "5 Minutes"
];

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key, required this.title});

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
  double _currentDistance = 20.0; // initial value for the slider
  bool showFastFood = true;
  String eachPersonTimeLimit = "1 minute";
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
                Text('100 km'),
              ],
            ),
            Slider(
              value: _currentDistance,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: '$_currentDistance km',
              onChanged: (double value) {
                setState(() {
                  _currentDistance = value;
                });
              },
            ),
            Text('Current distance: $_currentDistance km'),
            // Add more filters here
            const SizedBox(height: 20),
            const Center(
                child: Text('Show Fast Food',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Switch.adaptive(
                value: showFastFood,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.blue,
                thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    showFastFood = value;
                  });
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
                print(values);
              },
              defaultSelected: const ["Sunday"],
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
                    items: list.map<DropdownMenuItem<String>>((String value) {
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

    // body: const Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: Text("Filters Page")));
  }
}

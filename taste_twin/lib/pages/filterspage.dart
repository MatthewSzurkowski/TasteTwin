import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/MainDrawer.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';

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
            Text('Search Distance'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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

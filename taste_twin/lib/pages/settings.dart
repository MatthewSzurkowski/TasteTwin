// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/MainDrawer.dart';

const List<Widget> icons = <Widget>[
  Icon(CupertinoIcons.brightness),
  Icon(Icons.dark_mode)
];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final List<bool> _selectedBrightness = <bool>[true, false];
  bool vertical = false;
  bool location_services = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 20),
            // ToggleButtons with icons only.
            const Text('Brightness Mode'),
            const SizedBox(height: 5),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedBrightness.length; i++) {
                    _selectedBrightness[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: _selectedBrightness,
              children: icons,
            ),
            const SizedBox(height: 20),
            // ToggleButtons with icons only.
            const Text('Location Services'),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Switch.adaptive(
                value: location_services,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.blue,
                thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    location_services = value;
                  });
                },
              ),
            ]),
          ],
        )),
        drawer: const MainDrawer(
          currentPage: 'Settings',
        ));
  }
}

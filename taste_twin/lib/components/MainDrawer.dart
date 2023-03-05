import 'package:flutter/material.dart';
import '../pages/filterspage.dart';
import '../pages/settings.dart';
import '../pages/about.dart';
import '../pages/homepage.dart';
import 'package:flutter/cupertino.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Taste Twin',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 38)),
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.home,
              color: Colors.black,
              size: 18,
            ),
            title: const Text('Homepage'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Taste Twin')),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.globe,
              color: Colors.black,
              size: 18,
            ),
            title: const Text('Search Filters'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FiltersPage(title: 'Filters')),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.gear,
              color: Colors.black,
              size: 18,
            ),
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SettingsPage(title: 'Settings')),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.info,
              color: Colors.black,
              size: 18,
            ),
            title: const Text('About'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AboutPage(title: 'About')),
              );
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:taste_twin/models/restaurant.dart';
import 'package:taste_twin/pages/results_page.dart';
import '../components/MainDrawer.dart';
import 'filterspage.dart';
import 'matchpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void parseJSON(String jsonString) {
    // Testing method to parse the JSON string given from the database and print out data
    List<dynamic> jsonList = json.decode(jsonString);

    for (dynamic json in jsonList) {
      int priceLevel = json['price_level'];
      String name = json['name'];
      String? description = json['description'];
      bool isFastFood = json['isFastFood'];
      String location = json['location'];
      String photoUrl = json['photo_url'];
      String type = json['type'];
      double distanceGuelph = json['distanceGuelph'];

      print('Price Level: $priceLevel');
      print('Name: $name');
      print('Description: $description');
      print('Is Fast Food: $isFastFood');
      print('Location: $location');
      print('Photo URL: $photoUrl');
      print('Type: $type');
      print('Distance to Guelph: $distanceGuelph km');
    }
  }

  List<Restaurant> parseRestaurants(String responseBody) {
    // This method parses the JSON response from the database and creates
    // restaurant objects for each JSON object and returns them in a list.
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
  }

  void readDB() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DatabaseEvent event = await ref.once();

    String dataStr = event.snapshot.value.toString();

    // parseJSON(dataStr);
    List<Restaurant> resList = parseRestaurants(dataStr);
    resList.forEach((Restaurant res) => print(res.name));
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(children: [
                SizedBox(
                  height: 32,
                  width: 150,
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.blue.withOpacity(0.04);
                            }
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed)) {
                              return Colors.blue.withOpacity(0.12);
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MatchPage(
                              title: 'Taste Twin',
                            ),
                          ),
                        );
                      },
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Find Food '),
                          Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ))),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const FiltersPage(
                          title: 'Filters',
                        ),
                      ),
                    );
                  },
                  child: const Text('Search Filters'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    readDB();
                  },
                  child: const Text('Test'),
                ),
              ]),
            ],
          ),
        ),
        drawer: const MainDrawer());
  }
}

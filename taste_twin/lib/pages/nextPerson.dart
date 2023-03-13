// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:taste_twin/models/restaurant.dart';

class NextPersonPage extends StatefulWidget {
  const NextPersonPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<NextPersonPage> createState() => _NextPersonPage();
}

class _NextPersonPage extends State<NextPersonPage> {
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
        body: Container(
            child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Switch to next person!",
                      style: TextStyle(
                          fontSize: 35, color: Color.fromARGB(255, 0, 0, 0))),
                  ElevatedButton(
                    onPressed: () {
                      print("Swap to next person");
                    },
                    child: Text("Next",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 255, 255, 255))),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(CupertinoIcons.clear_circled,
                    size: 40, color: Color.fromARGB(255, 44, 44, 44)),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(CupertinoIcons.heart,
                    size: 40, color: Color.fromARGB(255, 44, 44, 44)),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ],
          )
        ])));
  }
}

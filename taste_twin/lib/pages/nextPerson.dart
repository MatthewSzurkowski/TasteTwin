// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_cards/draggable_card.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:taste_twin/models/restaurant.dart';
import '../components/rest.dart';
import '../main.dart';
import './matchpage.dart';
import 'results_page.dart';
import 'homepage.dart';

class NextPersonPage extends StatefulWidget {
  //REMOVE MATCHES LATER
  const NextPersonPage({super.key, required this.title, required this.matches});
  final List<Rest> matches;
  final String title;

  @override
  State<NextPersonPage> createState() => _NextPersonPage();
}

class _NextPersonPage extends State<NextPersonPage> {
  @override
  Widget build(BuildContext context) {
    List<Rest> matches = widget.matches;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer(builder: (context, ref, _) {
      final notifier = ref.watch(preferencesProvider.notifier);
      final preferences = ref.watch(preferencesProvider);
      return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: Column(children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Switch to next person!",
                        style: TextStyle(
                            fontSize: 35, color: Color.fromARGB(255, 0, 0, 0))),
                    ElevatedButton(
                      onPressed: () {
                        notifier.decrementUsers();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MatchPage(
                              title: 'Matches',
                            ),
                          ),
                        );
                      },
                      child: const Text("Next",
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
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(CupertinoIcons.clear_circled,
                      size: 40, color: Color.fromARGB(255, 44, 44, 44)),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(CupertinoIcons.heart,
                      size: 40, color: Color.fromARGB(255, 44, 44, 44)),
                ),
              ],
            )
          ]));
    });
  }
}

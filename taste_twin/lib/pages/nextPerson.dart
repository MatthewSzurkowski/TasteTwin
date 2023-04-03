import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/rest.dart';
import '../main.dart';
import './matchpage.dart';

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer(builder: (context, ref, _) {
      final notifier = ref.watch(preferencesProvider.notifier);
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
                    const Text("Switch to the Next Person!",
                        style: TextStyle(
                            fontSize: 30, color: Color.fromARGB(255, 0, 0, 0))),
                    ElevatedButton(
                      onPressed: () {
                        notifier.decrementUsers();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MatchPage(
                              title: 'TasteTwin',
                            ),
                          ),
                        );
                      },
                      child: const Text("Next",
                          style: TextStyle(
                              fontSize: 35,
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
                  child: const Icon(CupertinoIcons.clear,
                      size: 40, color: Color.fromARGB(255, 44, 44, 44)),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(CupertinoIcons.star,
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

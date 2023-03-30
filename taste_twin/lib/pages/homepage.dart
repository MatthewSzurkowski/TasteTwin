import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:taste_twin/models/restaurant.dart';
import 'package:taste_twin/pages/results_page.dart';
import '../components/MainDrawer.dart';
import 'filterspage.dart';
import 'matchpage.dart';
import '../components/preferences.dart';
import '../components/preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
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
                                builder: (BuildContext context) =>
                                    const MatchPage(
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
                            builder: (BuildContext context) => FiltersPage(
                              title: 'Filters',
                              preferences: "text",
                            ),
                          ),
                        );
                      },
                      child: const Text('Search Filters'),
                    ),
                    //Text("${notifier.getSelectedCuisines()}"),
                  ]),
                ],
              ),
            ),
            drawer: const MainDrawer());
      },
    );
  }
}

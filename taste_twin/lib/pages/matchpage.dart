import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:taste_twin/components/preferences_provider.dart';
import 'package:taste_twin/components/rest.dart';
import 'package:taste_twin/components/userPreferences_provider.dart';
import 'package:taste_twin/pages/nextPerson.dart';
import 'results_page.dart';
import 'package:taste_twin/models/restaurant.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taste_twin/main.dart';

class Content {
  final String text;
  final Color color;
  final String name;
  final String location;
  final String? price;
  final String? type;
  final String? description;
  final String? pictureUrl;
  final double distanceGuelph;
  bool isCardFlipped;
  final List<String> tags;

  void setIsCardFlipped(bool value) {
    isCardFlipped = value;
  }

  bool getIsCardFlipped() {
    return isCardFlipped;
  }

  Content({
    required this.text,
    required this.color,
    required this.name,
    required this.location,
    required this.price,
    required this.type,
    required this.description,
    required this.pictureUrl,
    required this.isCardFlipped,
    required this.distanceGuelph,
    required this.tags,
  });
}

class MatchPage extends StatefulWidget {
  const MatchPage({super.key, required this.title});
  final String title;

  @override
  State<MatchPage> createState() => _MatchPage();
}

class _MatchPage extends State<MatchPage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  final List<Rest> _matches = <Rest>[];
  late MatchEngine _matchEngine;
  List<Restaurant> restaurants = <Restaurant>[];
  int startTimeInt = 0;
  int interations = 0;

  List<Restaurant> parseRestaurants(String responseBody) {
    // This method parses the JSON response from the database and creates
    // restaurant objects for each JSON object and returns them in a list.
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
  }

  void readDB() async {
    // ignore: unused_local_variable
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DatabaseEvent event = await ref.once();
    restaurants = parseRestaurants(event.snapshot.value.toString());
  }

  Future<List<dynamic>> readDB2() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DatabaseEvent event = await ref.once();
    restaurants = parseRestaurants(event.snapshot.value.toString());
    return restaurants;
  }

  var beginningTimeInSeconds = 0.0;
  int globalRemUsers = 1;
  late DateTime globalStartTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    //readDB();
    // List<Restaurant> restaurants = readDB();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    Future.delayed(const Duration(seconds: 1), () {
      globalStartTime = DateTime.now();
      var cond = 0;
      setState(() {
        for (int i = 0; i < restaurants.length; i++) {
          _swipeItems.add(SwipeItem(
              content: Content(
                isCardFlipped: false,
                text: restaurants[i].name,
                name: restaurants[i].name,
                location: restaurants[i].location,
                price: restaurants[i].price,
                type: restaurants[i].type,
                description: restaurants[i].description,
                pictureUrl: restaurants[i].pictureURL,
                distanceGuelph: restaurants[i].distanceGuelph,
                color: Colors.white,
                tags: restaurants[i].tags,
              ),
              likeAction: () {
                DateTime now = DateTime.now();
                Duration difference = now.difference(globalStartTime);
                double differenceInSeconds = difference.inMilliseconds / 1000;
                _handleLikedRestaurant(differenceInSeconds, i);
                cond = 0;
              },
              nopeAction: () {
                cond = 0;
              },
              superlikeAction: () {
                _handleLikedRestaurant(0, i);
                cond = 0;
              },
              onSlideUpdate: (SlideRegion? region) async {
                if (cond == 0) {
                  globalStartTime = DateTime.now();
                }
              }));
        }
      });
    });
  }

  late PreferencesNotifier globalNotifier;
  late UserPreferencesNotifier globalUserPreferencesNotifier;
  // ignore: unused_field
  Timer? _timer;
  CountdownTimerController? _timerController;
  int startTimerCondition = 0;

  void _startTimer() {
    final Duration timerDuration = Duration(seconds: globalNotifier.getTime());
    // _timer = Timer(timerDuration, _navigateToNextPage);

    int endTime =
        DateTime.now().millisecondsSinceEpoch + timerDuration.inMilliseconds;

    _timerController =
        CountdownTimerController(endTime: endTime, onEnd: _navigateToNextPage);
  }

  void _navigateToNextPage() {
    //print(globalNotifier.getRemUsers());
    if (mounted) {
      if (globalNotifier.getRemUsers() > 1) {
        globalUserPreferencesNotifier.addMatch(_matches);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Times up! Switch to the next person"),
          duration: Duration(milliseconds: 5000),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NextPersonPage(
              title: 'TasteTwin',
              matches: _matches,
            ),
          ),
        );
      } else {
        globalUserPreferencesNotifier.addMatch(_matches);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Times up! Showing Results"),
          duration: Duration(milliseconds: 5000),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ResultsPage(
              title: 'Results',
              matches: _matches,
            ),
          ),
        );
      }
    }
  }

  bool _showSwipeCards = true;

  void _handleStackFinished() {
    setState(() {
      _showSwipeCards = false;
    });
  }

  void _handleLikedRestaurant(double time, int index) {
    Rest restaurantObject = Rest(rest: restaurants[index], time: time);
    _matches.add(restaurantObject);
  }

  // Toggle if card is flipped or not.
  void _flipCard(SwipeItem item) {
    setState(() {
      item.content.setIsCardFlipped(!item.content.getIsCardFlipped());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final notifier = ref.watch(preferencesProvider.notifier);
      globalNotifier = notifier;
      if (startTimerCondition == 0) {
        _startTimer();
        startTimerCondition = 1;
      }
      final userPreferences = ref.watch(userPreferencesProvider);
      final userPreferencesNotifier =
          ref.watch(userPreferencesProvider.notifier);
      globalUserPreferencesNotifier = userPreferencesNotifier;

      bool allowFastFood = notifier.getFastFood();

      //Get the restaurants that the user has unliked
      List<String> options = [
        "Italian",
        "Chinese",
        "Mexican",
        "Indian",
        "Canadian",
        "Greek",
        "American",
      ];

      List<dynamic> values = notifier.getSelectedCuisines();
      List<String> cuisinesNotChosen = [];

      //Get the list of unselected cuisines
      for (int i = 0; i < options.length; i++) {
        if (!values.contains(options[i])) {
          cuisinesNotChosen.add(options[i]);
        }
      }

      double distance = notifier.getSearchDistanceValue();

      for (int i = 0; i < _swipeItems.length; i++) {
        if (_swipeItems.isEmpty) {
          globalRemUsers = 0;
          _showSwipeCards = false;
        }
        //If the user doesn't want fast food, remove fast food restaurants
        bool skipped = false;
        //print(_swipeItems[i].content.tags.toString());

        if (!allowFastFood) {
          if (_swipeItems[i].content.tags.contains("Fast Food")) {
            _swipeItems.removeAt(i);
            i -= 1;
            skipped = true;
            //break;
          }
        }

        if (skipped) {
          continue;
        }

        //If they don't want a cuisine, remove it
        for (int j = 0; j < cuisinesNotChosen.length; j++) {
          if (_swipeItems[i].content.tags.contains(cuisinesNotChosen[j])) {
            _swipeItems.removeAt(i);
            i -= 1;
            skipped = true;
            break;
          }
        }
        if (skipped) {
          if (_swipeItems.isEmpty) {
            globalRemUsers = 0;
            _showSwipeCards = false;
          }
          continue;
        }
        //Remove restaurants that are too far away
        if (_swipeItems[i].content.distanceGuelph > distance) {
          _swipeItems.removeAt(i);
          i -= 1;
        }
        if (_swipeItems.isEmpty) {
          globalRemUsers = 0;
          _showSwipeCards = false;
        }
      }

      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            leading: CountdownTimer(
                controller: _timerController,
                widgetBuilder: (context, time) => Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 3),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(CupertinoIcons.time, size: 16),
                        ),
                        Text(
                            "${time?.min ?? ""}${time?.min == null ? "" : ":"}${time?.sec.toString().padLeft(2, '0') ?? ""}"),
                      ],
                    ))),
          ),
          body: _showSwipeCards
              ? Column(children: [
                  Expanded(
                      child: FutureBuilder(
                          future: readDB2(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return Column(children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  width: 400,
                                  child: SwipeCards(
                                    matchEngine: _matchEngine,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color:
                                              _swipeItems[index].content.color,
                                        ),
                                        alignment: Alignment.center,
                                        child: card(_swipeItems[index]),
                                      );
                                    },
                                    onStackFinished: () {
                                      userPreferencesNotifier
                                          .addMatch(_matches);
                                      print(
                                          "Matches object: ${userPreferences.matches}");
                                      _handleStackFinished();
                                    },
                                    itemChanged: (SwipeItem item, int index) {
                                      // for (var i = 0;
                                      //     i < _matches.length;
                                      //     i++) {
                                      //   print(
                                      //       "List of Restaurants ${i + 1}: ${_matches[i].rest!.name}, ${_matches[i].time}");
                                      // }
                                    },
                                    upSwipeAllowed: true,
                                    fillSpace: true,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () {
                                        _matchEngine.currentItem?.nope();
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.white,
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      child: const Icon(CupertinoIcons.clear,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 132, 18, 18)),
                                    ),
                                    RawMaterialButton(
                                      onPressed: () {
                                        _matchEngine.currentItem?.superLike();
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.white,
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      child: const Icon(CupertinoIcons.star,
                                          size: 40, color: Colors.blue),
                                    ),
                                    RawMaterialButton(
                                      onPressed: () {
                                        _matchEngine.currentItem?.like();
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.white,
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      child: const Icon(CupertinoIcons.heart,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 15, 128, 15)),
                                    ),
                                  ],
                                )
                              ]);
                            }
                          }))
                ])
              : Center(child: Builder(
                  builder: (context) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if ((notifier.getRemUsers() > 1) && globalRemUsers > 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => NextPersonPage(
                              title: 'TasteTwin',
                              matches: _matches,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ResultsPage(
                              title: 'Results',
                              matches: _matches,
                            ),
                          ),
                        );
                      }
                    });
                    return Container();
                  },
                )));
    });
  }

  // Builds the card displaying a restauarant.
  Widget card(SwipeItem item) {
    return Container(
      child: !item.content.getIsCardFlipped()
          ? Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.content.pictureUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.76,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.content.name,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              Text(item.content.price,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                              Text("${item.content.distanceGuelph} kms away",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ],
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Toggle if card is flipped or not.
                                _flipCard(item);
                              },
                              icon: const Icon(CupertinoIcons.info,
                                  size: 40, color: Colors.white),
                            )
                          ],
                        ))
                  ],
                )
              ],
            )
          : SizedBox(
              width: 400,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${item.content.description}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Location",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${item.content.location}\n${item.content.distanceGuelph} km away.",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            _flipCard(item);
                          },
                          icon: const Icon(CupertinoIcons.info,
                              size: 40, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

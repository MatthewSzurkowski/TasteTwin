import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:taste_twin/components/rest.dart';
import 'package:taste_twin/components/userPreferences.dart';
import 'package:taste_twin/pages/nextPerson.dart';
import 'results_page.dart';
import 'package:taste_twin/models/restaurant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/UserPreferences_provider.dart';
import 'results_page.dart';
import 'package:taste_twin/main.dart';


class Content {
  final String text;
  final Color color;
  final String name;
  final int location;
  final String price;
  final String type;
  final String description;
  final String pictureUrl;

  Content(
      {required this.text,
      required this.color,
      required this.name,
      required this.location,
      required this.price,
      required this.type,
      required this.description,
      required this.pictureUrl});
}

class MatchPage extends StatefulWidget {
  const MatchPage({super.key, required this.title});
  final String title;

  @override
  State<MatchPage> createState() => _MatchPage();
}

class _MatchPage extends State<MatchPage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  List<Rest> _matches = <Rest>[];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int startTimeInt = 0;
  int interations = 0;

  @override
  void initState() {
    DateTime now = DateTime.now();

    var startTime = "${now.hour}${now.minute}${now.second}";
    startTimeInt = int.parse(startTime);

    for (int i = 0; i < tempRestaurantList.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(
              text: tempRestaurantList[i].name,
              name: tempRestaurantList[i].name,
              location: tempRestaurantList[i].location,
              price: tempRestaurantList[i].price,
              type: tempRestaurantList[i].type,
              description: tempRestaurantList[i].description,
              pictureUrl: tempRestaurantList[i].pictureURL,
              color: Colors.white),
          likeAction: () {
            DateTime now = DateTime.now();

            var endTime = "${now.hour}${now.minute}${now.second}";
            int endTimeInt = int.parse(endTime);
            int difference = endTimeInt - startTimeInt;

            _handleLikedRestaurant(difference, i);
          },
          nopeAction: () {},
          onSlideUpdate: (SlideRegion? region) async {}));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  bool _showSwipeCards = true;

  void _handleStackFinished() {
    setState(() {
      _showSwipeCards = false;
    });
  }

  void _handleLikedRestaurant(int time, int index) {
    Rest restaurantObject = Rest();
    restaurantObject.setRestaurant(tempRestaurantList[index]);
    restaurantObject.setTime(time);

    _matches.add(restaurantObject);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final notifier = ref.watch(preferencesProvider.notifier);
      final preferences = ref.watch(preferencesProvider);
      final userPreferences = ref.watch(userPreferencesProvider);
      final userPreferencesNotifier = ref.watch(userPreferencesProvider.notifier);
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: _showSwipeCards
              ? Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: 400,
                    child: SwipeCards(
                      matchEngine: _matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: _swipeItems[index].content.color,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        _swipeItems[index].content.pictureUrl),
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
                                mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                        MainAxisAlignment.end,
                                      crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _swipeItems[index].content.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                        Text(_swipeItems[index].content.price,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255))),
                                        Text(
                                            "${_swipeItems[index].content.location} kms away",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              print("Clicked");
                                            },
                                            icon: const Icon(
                                                CupertinoIcons.info,
                                                size: 40,
                                                color: Colors.white),
                                          )
                                        ],
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      onStackFinished: () {
                        userPreferencesNotifier.addMatch(_matches);
                        _handleStackFinished();
                      },
                      itemChanged: (SwipeItem item, int index) {
                        DateTime now = DateTime.now();

                          var startTime =
                              "${now.hour}${now.minute}${now.second}";
                          startTimeInt = int.parse(startTime);

                        print("item: ${item.content.text}, index: $index");
                        print(notifier.getRemUsers());
                      },
                      upSwipeAllowed: false,
                      fillSpace: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          _matchEngine.currentItem?.nope();
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        child: const Icon(CupertinoIcons.clear_circled,
                            size: 40, color: Color.fromARGB(255, 132, 18, 18)),
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
                            size: 40, color: Color.fromARGB(255, 15, 128, 15)),
                      ),
                    ],
                  )
                ])
              : Center(child: Builder(
                  builder: (context) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (notifier.getRemUsers() > 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => NextPersonPage(
                              title: 'Taste Twin',
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
}

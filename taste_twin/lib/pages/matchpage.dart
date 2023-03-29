import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:taste_twin/pages/nextPerson.dart';
import 'results_page.dart';
import 'package:taste_twin/models/restaurant.dart';

class Content {
  final String text;
  final Color color;
  final String name;
  final int location;
  final String price;
  final String type;
  final String description;
  final String pictureUrl;
  bool isCardFlipped;

  void setIsCardFlipped(bool value) {
    isCardFlipped = value;
  }

  bool getIsCardFlipped() {
    return isCardFlipped;
  }

  Content(
      {required this.text,
      required this.color,
      required this.name,
      required this.location,
      required this.price,
      required this.type,
      required this.description,
      required this.pictureUrl,
      required this.isCardFlipped});
}

class MatchPage extends StatefulWidget {
  const MatchPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MatchPage> createState() => _MatchPage();
}

class _MatchPage extends State<MatchPage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  List<Restaurant> _matches = <Restaurant>[];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    for (int i = 0; i < tempRestaurantList.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(
              isCardFlipped: false,
              text: tempRestaurantList[i].name,
              name: tempRestaurantList[i].name,
              location: tempRestaurantList[i].location,
              price: tempRestaurantList[i].price,
              type: tempRestaurantList[i].type,
              description: tempRestaurantList[i].description,
              pictureUrl: tempRestaurantList[i].pictureURL,
              color: Colors.white),
          likeAction: () {
            _handleLikedRestaurant(i);
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Liked ${tempRestaurantList[i].name}"),
            //   duration: const Duration(milliseconds: 500),
            // ));
          },
          nopeAction: () {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Nope ${tempRestaurantList[i].name}"),
            //   duration: const Duration(milliseconds: 500),
            // ));
          },
          superlikeAction: () {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Superliked ${tempRestaurantList[i].name}"),
            //   duration: const Duration(milliseconds: 500),
            // ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  bool _showSwipeCards = true;
  bool _isCardFlipped = false;

  void _handleStackFinished() {
    setState(() {
      _showSwipeCards = false;
    });
  }

  void _handleLikedRestaurant(int index) {
    _matches.add(tempRestaurantList[index]);
  }

  // Toggle if card is flipped or not.
  void _flipCard(SwipeItem item) {
    setState(() {
      item.content.setIsCardFlipped(!item.content.getIsCardFlipped());
    });
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
        body: _showSwipeCards
            ? Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: 400,
                  child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: _swipeItems[index].content.color,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: card(_swipeItems[index]),
                      );
                    },
                    onStackFinished: () {
                      _handleStackFinished();
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${item.content.text}, index: $index");
                    },
                    upSwipeAllowed: true,
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
                //if the current user = numUsers.length(), go to results
                // ELSE: go to next person page
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => NextPersonPage(
                          title: 'Taste Twin',
                          matches: _matches,
                        ),
                      ),
                    );
                  });
                  return Container();
                },
              )));
  }

  // Builds the card displaying a restauarant.
  Widget card(SwipeItem item) {
    return Container(
      child: !item.content.getIsCardFlipped()
          ? Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(item.content.pictureUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                  color: Color.fromARGB(255, 255, 255, 255))),
                          Text("${item.content.location} kms away",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ],
                      ),
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
          : Container(
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.blue, width: 2)),
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
                            "${item.content.location} km away.",
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

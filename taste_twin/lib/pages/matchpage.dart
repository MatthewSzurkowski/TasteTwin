// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:swipe_cards/swipe_cards.dart';
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
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
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
              color: _colors[i % _colors.length]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${tempRestaurantList[i].name}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${tempRestaurantList[i].name}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${tempRestaurantList[i].name}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
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
        body: Container(
            child: Column(children: [
          Container(
            height: 550,
            width: 400,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: _swipeItems[index].content.color,
                  child: Stack(
                    children: [
                      FittedBox(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(
                              _swipeItems[index].content.pictureUrl),
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
                                  _swipeItems[index].content.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                Text(
                                    _swipeItems[index]
                                            .content
                                            .location
                                            .toString() +
                                        " kms away",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                                Text(_swipeItems[index].content.price,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      print("Clicked");
                                    },
                                    icon: Icon(CupertinoIcons.info,
                                        size: 40, color: Colors.white),
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
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
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem?.nope();
                  },
                  child: const Text("Nope")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem?.superLike();
                  },
                  child: const Text("Superlike")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem?.like();
                  },
                  child: const Text("Like"))
            ],
          )
        ])));
  }
}

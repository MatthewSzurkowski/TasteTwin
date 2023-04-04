import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../components/rest.dart';
import '../components/rank.dart';
import 'homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taste_twin/main.dart';

// Page to display the results of the matching process. Shows a list of
// restauarants ranked based on the matches between those who used the app.
class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, required this.matches, required String title});
  final List<Rest> matches;

  @override
  Widget build(BuildContext context) {
    //Sort the list
    //List<Rest> sortedMatches = matches;
    //sortedMatches.sort((a, b) => a.getTime().compareTo(b.getTime()));
    List<Rest> sortedMatches = [];
    return Consumer(builder: (context, ref, _) {
      final userPreferencesNotifier =
          ref.watch(userPreferencesProvider.notifier);
      bool contains = true;
      List<Rank> finalSet = [];
      List<List<Rest>> userChoices = userPreferencesNotifier.getMatches();
      //Iterate through the list of users
      for (int i = 0; i < userChoices.length; i++) {
        //Iterate through the list of choices for each user
        //print("User $i");
        for (int j = 0; j < userChoices[i].length; j++) {
          contains = false;
          for (int x = 0; x < finalSet.length; x++) {
            if (finalSet[x].rest!.rest!.name == userChoices[i][j].rest!.name) {
              contains = true;
              finalSet[x].addUser();
              finalSet[x].addTime(userChoices[i][j].time);
              finalSet[x].time += userChoices[i][j].time;
            }
          }
          if (!contains) {
            var restObj = Rank(
                rest: userChoices[i][j],
                numUsers: 1,
                time: userChoices[i][j].time);
            finalSet.add(restObj);
          }
        }
      }

      finalSet.sort((a, b) {
        if (a.numUsers != b.numUsers) {
          // sort by numUsers in descending order
          return b.numUsers.compareTo(a.numUsers);
        } else {
          // subsort by time in ascending order
          return a.time.compareTo(b.time);
        }
      });

      for (int i = 0; i < finalSet.length; i++) {
        sortedMatches.add(finalSet[i].rest!);
        print(
            "finalSet[$i]: ${finalSet[i].rest!.rest!.name},${finalSet[i].time},${finalSet[i].numUsers}");
      }

      //Sort by the time
      // finalSet.sort((a, b) => a.getUsers().compareTo(b.getUsers()));
      // sortedMatches = finalSet;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Results"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (finalSet.isEmpty)
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    "No matches found. Try again!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    "Finished! Your matches are...",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              // Title

              // Scrollable list of Results
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.blue, width: 2)),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemBuilder: ((context, index) {
                      return Column(children: [
                        ExpansionTile(
                          leading: Text(
                            "#${index + 1}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                    width: 80,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // your button action goes here
                                        String location = sortedMatches[index]
                                            .getRestaurant()!
                                            .location;
                                        final splitted = location.split(' ');
                                        String mapsUrl =
                                            'https://www.google.com/maps/search/?api=1&query=';
                                        for (int i = 0;
                                            i < splitted.length;
                                            i++) {
                                          mapsUrl += splitted[i];
                                          mapsUrl += '+';
                                        }
                                        launchUrlString(mapsUrl);
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.location,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      label: const Text(
                                        'Find',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                )
                              ]),
                          title: Text(
                            sortedMatches[index].getRestaurant()!.name,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.038, // set font size based on screen width
                            ),
                          ),
                          subtitle: Text(
                            "${sortedMatches[index].getRestaurant()!.type} - ${sortedMatches[index].getRestaurant()!.price}",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.028, // set font size based on screen width
                            ),
                          ),
                          children: [
                            Text(
                              sortedMatches[index]
                                  .getRestaurant()!
                                  .description
                                  .toString(),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${sortedMatches[index].getRestaurant()!.location}\nOnly ${sortedMatches[index].getRestaurant()!.distanceGuelph} km from you.",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: .5,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ]);
                    }),
                    itemCount: sortedMatches.length,
                  ),
                ),
              ),

              // Back to Search button
              Container(
                margin: const EdgeInsets.all(20),
                child: SizedBox(
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
                    onPressed: (() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const MyHomePage(
                            title: 'TasteTwin',
                          ),
                        ),
                      );
                    }),
                    child: const Center(
                      child: Text("Back to Search"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

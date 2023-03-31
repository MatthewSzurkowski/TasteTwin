import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taste_twin/models/restaurant.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../components/rest.dart';
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
    List<Rest> sortedMatches = matches;
    sortedMatches.sort((a, b) => a.getTime().compareTo(b.getTime()));

    return Consumer(builder: (context, ref, _) {
      final userPreferences = ref.watch(userPreferencesProvider);
      final userPreferencesNotifier =
          ref.watch(userPreferencesProvider.notifier);

      print(
          "userPreferencesNotifier.getMatches() ${userPreferencesNotifier.getMatches()}");

      List<Rest> finalSet = [];
      List<List<Rest>> arrayOfChoices = userPreferencesNotifier.getMatches();

      // print("Example name ${arrayOfChoices[0][0].getName()}");

      // Loop through and get a complete SET of all restaurants right swipped
      for (int i = 0; i < arrayOfChoices.length; i++) {
        for (int j = 0; j < arrayOfChoices[i].length; j++) {
          //If the restaurant is not in the set, add it
          if (finalSet.where((rest) =>
                      rest.getName() == arrayOfChoices[i][j].getName()) ==
                  0 ||
              finalSet.isEmpty) {
            finalSet.add(arrayOfChoices[i][j]);

            //If it already exists, add the time to it.
          } else {
            finalSet[finalSet.indexOf(arrayOfChoices[i][j].getRestaurant())]
                .addTime(arrayOfChoices[i][j].getTime());
            finalSet[finalSet.indexOf(arrayOfChoices[i][j])].addUser();
          }
        }
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
              // Title
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
                                        String mapsUrl =
                                            'https://www.google.com/maps/search/?api=1&query=the+manor+guelph';
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
                          title:
                              Text(sortedMatches[index].getRestaurant().name),
                          subtitle: Text(
                            "${sortedMatches[index].getRestaurant().type} - ${sortedMatches[index].getRestaurant().price}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          children: [
                            Text(sortedMatches[index]
                                .getRestaurant()
                                .description),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Only ${sortedMatches[index].getRestaurant().location} km from you.",
                              style: const TextStyle(fontSize: 12),
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
                            title: 'Taste Twin',
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

import 'package:flutter/material.dart';
import 'package:taste_twin/models/restaurant.dart';

// Page to display the results of the matching process. Shows a list of
// restauarants ranked based on the matches between those who used the app.
class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, required this.matches});

  final List<Restaurant> matches;

  @override
  Widget build(BuildContext context) {
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
                    return ExpansionTile(
                      leading: Text(
                        "#${index + 1}",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(matches[index].name),
                      subtitle: Text(
                        "${matches[index].type} - ${matches[index].price}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      children: [
                        Text(matches[index].description),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Only ${matches[index].location} km from you.",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    );
                  }),
                  itemCount: matches.length,
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
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: (() {
                    Navigator.of(context).pop();
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
  }
}

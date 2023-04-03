// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/MainDrawer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  @override
  State<AboutPage> createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  bool vertical = false;

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
        body: Center(
            child: Column(
          children: const [
            SizedBox(height: 20),
            Text(
              "The Team",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Text("Matthew Szurkowski"),
            Text("Tristan Kerec"),
            Text("Ian McKechnie"),
            Text("Chris Vandoodewaard"),
            Text("Tyler Ykema"),
            SizedBox(height: 20),
            Text(
              "Information & Privacy",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  "We use location services to provide accurate and useful suggestions of restauarants you may be interested in. We do not store this information. We do not store any personally identifiable information. "),
            )
          ],
        )),
        drawer: const MainDrawer(
          currentPage: 'About',
        ));
  }
}

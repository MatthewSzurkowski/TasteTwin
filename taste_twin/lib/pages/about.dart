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
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non efficitur augue, in condimentum lacus. Integer et volutpat leo. Mauris id vehicula urna. Pellentesque ornare congue dictum. Vivamus luctus sem vel justo ullamcorper, ac elementum felis mattis. Quisque semper mi ut erat vulputate dictum. Integer quis elit non odio pellentesque eleifend sit amet ac mauris. Quisque tempor id ipsum sed sagittis. Proin eu ante mi. Curabitur fermentum erat vel urna dapibus, id pharetra nisl aliquam. Quisque laoreet, sem ac dapibus laoreet, dolor nisl bibendum nunc, et pharetra tortor odio id erat. In eget mi in erat commodo fermentum. Aenean cursus, tellus eget semper viverra, massa leo sollicitudin sem, nec ultricies sem quam id nisi.Nam et magna tempus massa porttitor congue. Phasellus ultricies mattis felis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lacus nulla, commodo id elit ac, egestas sagittis tellus. Aliquam iaculis elementum suscipit. Cras a lobortis sem, quis congue justo. Integer congue nisl non metus iaculis, eu commodo velit accumsan. Curabitur ut augue interdum, ullamcorper libero quis, interdum nisi. Morbi vel tellus luctus, congue metus quis, egestas lorem. Phasellus id iaculis leo. In sagittis dictum finibus. Etiam in finibus risus, id vulputate eros.Donec malesuada mauris vel ante pharetra interdum. Fusce at malesuada lacus. In orci erat, posuere quis faucibus eget, ullamcorper a elit."),
          ],
        )),
        drawer: const MainDrawer(
          currentPage: 'About',
        ));
  }
}

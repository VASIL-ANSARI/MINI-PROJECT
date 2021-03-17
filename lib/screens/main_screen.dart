import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  int index = 0;
  List<double> list = [200.0, 100.0, 100.0];

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = IntTween(begin: 0, end: 2).animate(controller);
    controller.forward();
    controller.addListener(() {
      print(animation.value);
      setState(() {
        index = animation.value;
      });
    });
  }

  @override
  void deactivate() {
    controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Container(
              child: Text(
                "Welcome Vasil Ansari,\nExplore more..",
                textAlign: TextAlign.start,
                textScaleFactor: 2.0,
                maxLines: 2,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(5.0),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Column(children: [
                Container(
                  child: Image.asset('images/clip-distance-learning-1.png'),
                  height: list[index],
                  width: list[index],
                ),
                TextButton(
                    onPressed: () {
                      _launchURLApp("https://www.hackathon.com/country/india");
                    },
                    child: Text("Explore Hackathons"))
              ]),
              Column(children: [
                Container(
                  child: Image.asset('images/clip-remote-learning.png'),
                  height: list[(index + 2) % 3],
                  width: list[(index + 2) % 3],
                ),
                TextButton(
                    onPressed: () {
                      _launchURLApp("http://mnnit.ac.in/index.php/avishkar");
                    },
                    child: Text("Explore Technical Events"))
              ]),
              Column(children: [
                Container(
                  child: Image.asset('images/gummy-programming.png'),
                  height: list[(index + 1) % 3],
                  width: list[(index + 1) % 3],
                ),
                TextButton(
                    onPressed: () {
                      _launchURLApp("http://mnnit.ac.in/index.php/culrav");
                    },
                    child: Text("Explore More"))
              ])
            ]),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Students Corner"),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            print("Home pressed");
          },
        ),
      ),
    );
  }

  _launchURLApp(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

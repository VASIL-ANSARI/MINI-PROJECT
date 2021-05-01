import 'package:flutter/material.dart';
import 'package:main_page_app/screens/Cse.dart';
import 'package:main_page_app/screens/YearEEE.dart';
import 'package:main_page_app/screens/quiz_screen.dart';
import 'package:main_page_app/screens/videos_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main_drawer.dart';

class MainScreen extends StatefulWidget{
  String name,branch,registration_number,email;
  MainScreen(this.name,this.registration_number,this.branch,this.email);
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState(name,registration_number,branch,email);
  }
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  String name,branch,registration_number,email;
  _MainScreenState(this.name,this.registration_number,this.branch,this.email);
  AnimationController controller;
  Animation animation;
  int index = 0;
  List<double> list = [200.0, 100.0, 100.0];

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation = IntTween(begin: 0, end: 2).animate(controller);
    controller.forward();
    controller.addListener(() {
      print(animation.value);
      setState(() {
        index = animation.value;
      });
      if(controller.status==AnimationStatus.completed){
        setState(() {
          index=0;
        });
      }
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
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Container(
              child: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  String _name=snapshot.data.getStringList(registration_number)[1];
                  return Padding(
                    padding: EdgeInsets.all(3.0),
                    child: TypewriterAnimatedTextKit(
                      text:["Welcome $_name"],
                      textAlign: TextAlign.start,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 45.0
                      ),
                    ),
                  );
                },
              ),

              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.yellow),
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
          Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(children: [
                Container(
                  child: Image.asset('images/clip-remote-learning.png'),
                  height: 200.0,
                  width: 200.0,
                ),
                TextButton(onPressed: () {
                  if(branch=='B.Tech CS'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return YearCSE();
                    }));
                  }
                  else if(branch=='B.Tech EE'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return YearEEE();
                    }));
                  }
                }, child: Text("Courses"))
              ])),
          Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(children: [
                Container(
                  child: Image.asset('images/flame-1196.png'),
                  height: 200.0,
                  width: 200.0,
                ),
                TextButton(onPressed: () {
                  navigateToQuizScreen();
                }, child: Text("Statistics and Quizzes"))
              ])),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(children: [
                Container(
                  child: Image.asset('images/pablita-94.png'),
                  height:100.0,
                  width: 100.0,
                ),
                TextButton(onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return VideoScreen(branch);
                  }));
                }, child: Text("Video Lectures"))
              ])),
        ],
      ),
      appBar: AppBar(
        title: Text("Students Corner"),
      ),
      drawer: MainDrawer(name,branch,registration_number,email),
    );
  }

  void navigateToQuizScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return QuizScreen(registration_number,branch);
    }));
  }

  _launchURLApp(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

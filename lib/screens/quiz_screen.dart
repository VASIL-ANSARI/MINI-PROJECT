import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/screens/end_screen.dart';
import 'package:main_page_app/screens/software_quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  String registration_number, branch;

  QuizScreen(this.registration_number, this.branch);

  @override
  State<StatefulWidget> createState() {
    return _QuizScreenState(registration_number, branch);
  }
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> Subjects = [];
  List<String> showSubjects = [];

  String branch, registration_number;
  TextEditingController titleController = TextEditingController();

  _QuizScreenState(this.registration_number, this.branch);

  @override
  void initState() {
    super.initState();
    if (branch.toLowerCase() == "b.tech cs") {
      Subjects.addAll(getCSLists());
    } else if (branch.toLowerCase() == "b.tech ee") {
      Subjects.addAll(getEELists());
    }
    showSubjects.addAll(Subjects);
    print(showSubjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.amberAccent,
        title: Container(
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(
                labelText: 'Search here...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            onChanged: (value) {
              setState(() {
                updateList(value);
              });
            },
          ),
          margin: EdgeInsets.all(2.0),
          padding: EdgeInsets.all(3.0),
        ),
      ),
      body: ListView(children: [
        Center(
          child: RoundedButton(
            onPressed: () {
              navigateToEndScreen();
            },
            title: "View Results",
            colour: Colors.teal,
          ),
        ),
        ListView(
          children: getChildrens(),
          shrinkWrap: true,
        )
      ]),
    );
  }

  void updateList(String val) {
    print(val.length);
    if (val.length == 0) {
      showSubjects.clear();
      showSubjects.addAll(Subjects);
    } else {
      val = val.toLowerCase();
      print(val);
      showSubjects.clear();
      for (String s in Subjects) {
        print(s.substring(0, val.length));
        if (s.substring(0, val.length).toLowerCase() == val) {
          showSubjects.add(s);
        }
      }
    }
    print(showSubjects);
  }

  List<Widget> getChildrens() {
    List<Widget> items = [];
    for (String s in showSubjects) {
      Widget widget = Container(
        child: RoundedButton(
          onPressed: () {
            _checkButton(s).then((value) => value
                ? null
                : () {});
          },
          title: s,
          colour: Colors.black,
        ),
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(8.0),
      );
      items.add(widget);
    }
    return items;
  }

  Future<bool> _checkButton(String s) async {
    var prefs = await SharedPreferences.getInstance();
    int val=prefs.getInt(registration_number+"_chances"+"_"+s);
    if(val<=0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorry no more attempts left'),backgroundColor: Colors.red,));
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$val attempts available'),backgroundColor: Colors.red,));
    navigateToSoftwareQuizScreen(s);
    return false;
  }

  void navigateToSoftwareQuizScreen(String s) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SoftwareQuiz(s, registration_number);
    }));
  }

  void navigateToEndScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EndScreen(Subjects.length, Subjects, registration_number);
    }));
  }

  List<String> getCSLists() {
    return [
      'Software engineering',
      'C++ Programming',
      'java Programming',
      'Discrete Mathematics',
      'Introduction to programming using pythons',
      'Data Structures and Algorithms'
    ];
  }

  List<String> getEELists() {
    return [
      'Power Electronics',
      'Microcontroller',
      'Operating System',
      'Data Structures'
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/constants.dart';
import 'package:main_page_app/screens/end_screen.dart';
import 'package:main_page_app/screens/software_quiz.dart';
import 'package:main_page_app/q_and_a/note.dart';

class QuizScreen extends StatefulWidget {
  String course;

  @override
  State<StatefulWidget> createState() {
    return _QuizScreenState();
  }
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> Subjects = [
    'Software engineering',
    'C++ Programming',
    'java Programming',
    'Discrete Mathematics',
    'Introduction to programming using pythons',
    'Data Structures and Algorithms'
  ];
  List<String> showSubjects = [];
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            child: RoundedButton(onPressed: (){
              navigateToEndScreen();
            },title: "View Results",colour: Colors.teal,),
          ),
          ListView(children:getChildrens(),shrinkWrap: true,)

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
            if (s == 'Software engineering') {
              navigateToSoftwareQuizScreen();
            }
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

  void navigateToSoftwareQuizScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SoftwareQuiz(Note(Subjects[0],"0","0","0"));
    }));
  }

  void navigateToEndScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EndScreen(Subjects.length, Subjects);
    }));
  }


}

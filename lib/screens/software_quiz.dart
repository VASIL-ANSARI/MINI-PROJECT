import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/q_and_a/question_answer.dart';
import 'package:main_page_app/q_and_a/note.dart';
import 'package:main_page_app/utils/database_helper.dart';

class SoftwareQuiz extends StatefulWidget {

  final Note note;
  SoftwareQuiz(this.note);
  @override
  State<StatefulWidget> createState() {
    return _SoftwareQuizState(note);
  }
}

class _SoftwareQuizState extends State<SoftwareQuiz> {
  int score = 0;
  int index = 0;
  Note note;
  DatabaseHelper helper = DatabaseHelper();
  bool isCompleted=false;
  _SoftwareQuizState(this.note);
  List<QA> questions = [
    QA('Choose the correct option in terms of Issues related to professional responsibility',
        'c', [
      'Confidentiality',
      'Intellectual property rights',
      'Both Confidentiality & Intellectual property rights',
      'Managing Client Relationships'
    ]),
    QA('"Software engineers should not use their technical skills to misuse other people’s computers."Here the term misuse refers to:',
        'd', [
      'Unauthorized access to computer material',
      'Unauthorized modification of computer material',
      'Dissemination of viruses or other malware',
      'All of the mentioned'
    ]),
    QA('Identify an ethical dilemma from the situations mentioned below:',
        'a', [
      'Your employer releases a safety-critical system without finishing the testing of the system',
      'Refusing to undertake a project',
      'Agreement in principle with the policies of senior management',
      'All of the mentioned'
    ]),
    QA(' The reason for software bugs and failures is due to', 'c', [
      'Software companies',
      'Software Developers',
      'Both',
      'All of the mentioned'
    ]),
    QA('Efficiency in a software product does not include ________', 'b', [
      'responsiveness',
      ' licensing',
      'memory utilization',
      ' processing time'
    ])
  ];

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz on Sofware Engineering"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(5.0),
            child: Text(
              questions[index].question,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          RoundedButton(
            onPressed: () {
              if (questions[index].answer == 'a') {
                setState(() {
                  if (!isCompleted) {
                    score++;
                    widgets.add(Container(
                        child: Icon(
                      Icons.check,
                      color: Colors.green,
                    )));
                  }
                });
              } else {
                setState(() {
                  if (!isCompleted) {
                    widgets.add(
                        Container(child: Icon(Icons.clear, color: Colors.red)));
                  }
                });
              }
              setState(() {
                if (index < questions.length - 1) {
                  index++;
                } else {

                  if(!isCompleted){
                    isCompleted=true;
                    int total_questions = questions.length;
                    _showAlertDialog("Score",
                        "Your Score is : $score out of $total_questions");
                  }

                }
              });
            },
            title: questions[index].choices[0],
            colour: Colors.red,
          ),
          RoundedButton(
              onPressed: () {
                if (questions[index].answer == 'b') {
                  setState(() {
                    if (!isCompleted) {
                      score++;
                      widgets.add(Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          )));
                    }
                  });
                } else {
                  setState(() {
                    if (!isCompleted) {
                      widgets.add(
                          Container(child: Icon(Icons.clear, color: Colors.red)));
                    }
                  });
                }
                setState(() {
                  if (index < questions.length - 1) {
                    index++;
                  } else {
                    if(!isCompleted){
                      isCompleted=true;
                      int total_questions = questions.length;
                      _showAlertDialog("Score",
                          "Your Score is : $score out of $total_questions");
                    }
                  }
                });
              },
              title: questions[index].choices[1],
              colour: Colors.red),
          RoundedButton(
            onPressed: () {
              if (questions[index].answer == 'c') {
                setState(() {
                  if (!isCompleted) {
                    score++;
                    widgets.add(Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        )));
                  }
                });
              } else {
                setState(() {
                  if (!isCompleted) {
                    widgets.add(
                        Container(child: Icon(Icons.clear, color: Colors.red)));
                  }
                });
              }
              setState(() {
                if (index < questions.length - 1) {
                  index++;
                } else {
                  if(!isCompleted){
                    isCompleted=true;
                    int total_questions = questions.length;
                    _showAlertDialog("Score",
                        "Your Score is : $score out of $total_questions");
                  }
                }
              });
            },
            title: questions[index].choices[2],
            colour: Colors.red,
          ),
          RoundedButton(
            onPressed: () {
              if (questions[index].answer == 'd') {
                setState(() {
                  if (!isCompleted) {
                    score++;
                    widgets.add(Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        )));
                  }
                });
              } else {
                setState(() {
                  if (!isCompleted) {
                    widgets.add(
                        Container(child: Icon(Icons.clear, color: Colors.red)));
                  }
                });
              }
              setState(() {
                if (index < questions.length - 1) {
                  index++;
                } else {
                  if(!isCompleted){
                    isCompleted=true;
                    int total_questions = questions.length;
                    _showAlertDialog("Score",
                        "Your Score is : $score out of $total_questions");
                  }
                }
              });
            },
            title: questions[index].choices[3],
            colour: Colors.red,
          ),
          Row(
            children: widgets,
          )
        ],
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
    _save();
  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    int result;
    note.marks0=score.toString();

    if (note.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(note);
    } else { // Case 2: Insert Operation
      print(note.title);
      result = await helper.insertNote(note);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }

  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }


}

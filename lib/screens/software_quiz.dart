import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/q_and_a/question_answer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoftwareQuiz extends StatefulWidget {

  String subject,registration_number;
  SoftwareQuiz(this.subject,this.registration_number);
  @override
  State<StatefulWidget> createState() {
    return _SoftwareQuizState(subject,registration_number);
  }
}

class _SoftwareQuizState extends State<SoftwareQuiz> {
  int score = 0;
  int index = 0;
  String subject,registration_number;
  bool isCompleted=false;
  _SoftwareQuizState(this.subject,this.registration_number);

  List<QA> questions = [];

  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    if(subject=='Software engineering'){
      questions.addAll(getSoftwareQuestions());

    }
    else if(subject=='C++ Programming'){
      questions.addAll(getCppQuestions());
    }
    else if(subject=='java Programming'){
      questions.addAll(getJavaQuestions());
    }
    else if(subject=='Discrete Mathematics'){
      questions.addAll(getDMQuestions());
    }
    else if(subject=='Introduction to programming using pythons'){
      questions.addAll(getPythonQuestions());
    }
    else if(subject=='Data Structures and Algorithms'){
      questions.addAll(getDSQuestions());
    }
    else if(subject=='Data Structures'){
      questions.addAll(getDSQuestions());
    }
    else if(subject=='Operating System'){
      questions.addAll(getOSQuestions());
    }
    else if(subject=='Microcontroller'){
      questions.addAll(getMicroQuestions());
    }
    else if(subject=='Power Electronics'){
      questions.addAll(getPEQuestions());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz on $subject"),
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
  }


  @override
  void dispose() {
    _save();
    super.dispose();
  }

  _save() async {
    var prefs = await SharedPreferences.getInstance();
    String key=registration_number+'_'+subject;
    if(prefs.getStringList(key)!=null){
      score=max(int.parse(prefs.getStringList(key)[0]),score);
    }
    prefs.setStringList(key,[score.toString()]);
    int val=prefs.getInt(registration_number+"_chances"+"_"+subject);
    prefs.setInt(registration_number+"_chances"+"_"+subject,val-1);
  }

  List<QA> getSoftwareQuestions(){
    return [
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
  }

  List<QA> getCppQuestions(){
    return [
      QA('What is the difference between struct and class in C++?','b',['All members of a structure are public and structures don\'t have constructors and destructors','Members of a class are private by default and members of struct are public by default. When deriving a struct from a class/struct, default access-specifier for a base class/struct is public and when deriving a class, default access specifier is private.',
      'All members of a structure are public and structures don\'t have virtual functions','All of these']),
      QA('Which of the following is true?','b',['All objects of a class share all data members of class','Objects of a class do not share non-static members. Every object has its own copy.',
      'Objects of a class do not share codes of non-static methods, they have their own copy','None of these']),
      QA('A member function can always access the data in __________ ','a',['the class of which it is member','the object of which it is a member',
      'the public part of its class','the private part of its class']),
      QA('Which of the following is not correct for virtual function in C++ ?','b',['Must be declared in public section of class.',
      'Virtual function can be static.','Virtual function should be accessed using pointers.','Virtual function is defined in base class.']),
      QA('Which of the following is not correct (in C++) ?\n'
    '1.Class templates and function templates are instantiated in the same way\n'
    '2.Class templates differ from function templates in the way they are initiated\n'
    '3.Class template is initiated by defining an object using the template argument\n'
    '4.Class templates are generally used for storage classes','c',['(1)','(2)(4)','(2)(3)(4)','(4)'])
    ];
  }

  List<QA> getJavaQuestions(){
    return [
      QA('In Java, when we implement an interface method, it must be declared as:','c',['private','protected','public'
      ,'friend']),
      QA('Which of the following is/are true about constructors in Java?\n'
      '1) Constructor name should be same as class name.\n'
    '2) If you don\'t define a constructor for a class,'
    'a default parameterless constructor is automatically'
    'created by the compiler.\n'
    '3) The default constructor calls super() and initializes all'
    'instance variables to default value like 0, null.\n'
    '4) If we want to parent class constructor, it must be called in'
    'first line of constructor.\n','d',['1','1 and 2','1,2 and 3','1,2,3 and 4']),
      QA('In Java, can we make functions inline like C++?','b',['Yes','No','May be','None of these']),
      QA('Which of the following is not an operator in Java?','b',['instanceOf','sizeof','new','>>>=']),
      QA('In Java, after executing the following code what are the values of x, y and z? int x,y=10; z=12; x=y++ + z++;','d',
      ['x=22, y=10, z=12','x=24, y=10, z=12','x=24, y=11, z=13','x=22, y=11, z=13'])
    ];
  }

  List<QA> getDMQuestions(){
    return [
      QA('A binary operation \oplus on a set of integers is defined as x \oplus y = x2 + y2. Which one of the following statements is TRUE about \oplus?','a',
      ['Commutative but not associative','Both commutative and associative','Associative but not commutative','Neither commutative nor associative']),
      QA('Which one of the following in NOT necessarily a property of a Group?','a',['Commutativity','Associativity',
    'Existence of inverse for every element','Existence of identity']),
      QA('Let S be a set of nelements. The number of ordered pairs in the largest and the smallest equivalence relations on S are:','b',
      ['n and n','n2 and n','n2 and 0','n and 1']),
      QA('How many different non-isomorphic Abelian groups of order 4 are there','a',['2','3','4','5']),
      QA('How many different equivalence relations with exactly three different equivalence classes are there on a set with five elements?','c',
      ['10','15','25','30'])
    ];
  }

  List<QA> getPythonQuestions(){
    return [
      QA('What is the output of the code shown below?\n'
          'set1 = {1, 2, 3}\n'
          'set2 = {4, 5, 6}\n'
          'print(len(set1 + set2))','d',['3','6','unepexted','error']),
      QA('What is the output of the following?\n'
      'True = False\n'
      'while True:\n'
    ' print(True)\n'
    ' break','c',['false','true','error','none']),
      QA('Which of these is not a core data type?','d',['list','dictionary','tuples','class']),
      QA('What data type is the object below ? L = [1, 23, ‘hello’, 1]','a',['list','dictionary','tuples','array']),
      QA('Which function overloads the >> operator?','d',['more','gt','ge','none of these'])
    ];
  }

  List<QA> getDSQuestions(){
    return [
      QA('Which of the following is true about linked list implementation of stack?','d',['In push operation, if new nodes are inserted at the beginning of linked list, then in pop operation, nodes must be removed from end.',
    'In push operation, if new nodes are inserted at the end, then in pop operation, nodes must be removed from the beginning.',
    'Both of the above',
    'None of the above']),
      QA('How many queues are needed to implement a stack. Consider the situation where no other data structure like arrays, linked list is available to you.','b',
      ['1','2','3','4']),
      QA('The maximum number of binary trees that can be formed with three unlabeled nodes is:','b',['1','5','4','3']),
      QA('A complete n-ary tree is a tree in which each node has n children or no children. Let I be the number of internal nodes and L be the number of leaves in a complete n-ary tree. If L = 41, and I = 10, what is the value of n?','d',
      ['6','3','4','5']),
      QA('Suppose we are sorting an array of eight integers using heapsort, and we have just finished some heapify (either maxheapify or minheapify) operations. The array now looks like this: 16 14 15 10 12 27 28 How many heapify operations have been performed on root of heap?','b',
      ['1','2','3 or 4','5 or 6'])
    ];
  }

  List<QA> getOSQuestions(){
    return [
      QA('Which of the following process scheduling algorithm may lead to starvation','c',['FIFO','Round Robin','Shortest Job Next','None of the above']),
      QA('If the quantum time of round robin algorithm is very large, then it is equivalent to:','a',['First in first out','Shortest Job Next','Lottery scheduling','None of the above']),
      QA('Which of the following statements are true?\n'
    'I. Shortest remaining time first scheduling may cause starvation\n'
    'II. Preemptive scheduling may cause starvation\n'
    'III. Round robin is better than FCFS in terms of response time','d',['I','I and III','II and III','I,II and III']),
      QA('Which of the following statement is true?','a',['Hard real time OS has less jitter than soft real time OS',
    'Hard real time OS has more jitter than soft real time OS','Hard real time OS has equal jitter as soft real time OS','None of the above']),
      QA('Which of the following is not an optimization criterion in the design of a CPU scheduling algorithm?','a',['Minimum CPU utilization','Maximum throughput',
    'Minimum turnaround time','Minimum waiting time'])
    ];
  }

  List<QA> getMicroQuestions(){
    return [
      QA('In 8086 microprocessor,the address bus is ____ bit','b',['10','20','16','12']),
      QA('Which file extension is used to load in a microcontroller to execute an instruction','d',['.doc','.txt','.c','.hex']),
      QA('What are the two instructions set architecture(ISA) classifications?','b',
          ['SIDC AND BIDC','CISC AND RISC','CISC AND VISC','NONE OF THESE']),
      QA('What is internal RAM memory of 8051 microcontroller?','c',[
        '32 bytes','64 bytes','128 bytes','256 bytes'
      ]),
      QA('How many timers/counters 8051 16-bit microprocessor have?','b',['1','2','5','8'])
    ];
  }

  List<QA> getPEQuestions(){
    return [
      QA('A triac is a -','a',[' 3 terminal bidirectional switch',
    '3 terminal bilateral switch',
    '2 terminal switch',
    '2 terminal bilateral switch']),
      QA('The minimum duration of the pulse in a pulse triggering system for thyristors should be at-','b',
      ['10ms','10us','30ms','15ms']),
      QA('The typical value of SCR for modern alternator is -','c',['1.5','1.2','0.5','1.0']),
      QA('Which statemnet is true for latching current?','c',['It is related to conduction process of device.',
    'It is related to turn off process of the device.',
    'It is related to turn on process of the device.',
    'None of the above']),
      QA('Which semiconductor power device out of the following,is not a current triggering device?','a',
      ['MOSFET','G.T.O','Triac','Thyristor'])
    ];
  }



}

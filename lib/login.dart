import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/constants.dart';
import 'package:main_page_app/screens/main_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:toast/toast.dart';

import 'another_screen.dart';

// ignore: must_be_immutable
class FirstScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Registration no',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Continue'),
                  onPressed: () {
                    isExist(nameController.text,context);
                  },
                )),
            Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,PageTransition(child: Signup(), type:PageTransitionType.scale ));
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
          ],
        ),
      ),
    );
  }

  void isExist(String reg,var context) async{
    if(reg.length!=8){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration number must be a 8 digit number'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else {
      var prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey(reg)){
        List<String> lists=prefs.getStringList(reg);
        List<String> emails=prefs.getStringList("emails");
        if(emails!=null){
          if(!emails.contains(lists[3])){
            emails.add(lists[3]);
            prefs.setStringList("emails", emails);
          }
        }else{
          emails=[];
          emails.add(lists[3]);
          prefs.setStringList("emails",emails);
        }
        if(lists[0]=="true"){
          navigateToAnotherScreen(context,lists[1],reg,lists[2],lists[3]);
        }
        else {
          Navigator.push(context, PageTransition(
              child: SecondScreen(reg), type: PageTransitionType.scale));
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration number do not exists'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
      }
    }
  }

  void navigateToAnotherScreen(var context,var name,var reg_no,var branch,var email){
    Navigator.pushReplacement(context,PageTransition(child: AnotherScreen(name,reg_no,branch,email), type:PageTransitionType.topToBottom ));
  }
}

class SecondScreen extends StatefulWidget{
  String reg_no;

  SecondScreen(this.reg_no);

  @override
  State<StatefulWidget> createState() {
    return _SecondScreenState(reg_no);
  }
}

// ignore: must_be_immutable
class _SecondScreenState extends State<SecondScreen> {

  String reg_no;
  bool _show=false;

  _SecondScreenState(this.reg_no);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> attachments = [];
  bool isHTML = false;

  Future<void> send(String emails,String body,String subject) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [emails],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'successfully sent';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login for Students"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      child: TextField(
                        obscureText: _show?false:true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      width: 300.0,
                    ),
                    Container(padding: EdgeInsets.all(3.0),),
                    SizedBox(
                      child :Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          child: Icon(_show?Icons.remove_red_eye:Icons.remove_red_eye_outlined,),
                          onPressed: (){
                            setState(() {
                              _show=!_show;
                            });
                          },
                        ),
                      ),
                      width: 50.0,
                    ),
                  ],
                ),
              )
            ),

            FlatButton(
              onPressed: (){
                _forgotPassword(context);
              },
              textColor: Colors.blue,
              child: Text('Forgot Password'),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: () {
                    isValid(passwordController.text,context);


                  },
                )),
            Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,PageTransition(child: Signup(), type:PageTransitionType.scale ));
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
          ],
        ),
      ),
    );
  }

  void isValid(String password,var context) async{
    if(password.length<5){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be of atleast 5 length.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(password.length>20){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password can be of atmost 20 length.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(password.contains(' ')){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should not contain spaces'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(isAlpha(password)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should contain atleast one number and one special character.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(isNumeric(password)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should contain atleast one lower case and one upper case character and one special character.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(isAlphanumeric(password)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should contain atleast one special character.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }else{
      var prefs=await SharedPreferences.getInstance();
      List<String> lists=prefs.getStringList(reg_no);
      //["true","Mohd vasil ansari","B.Tech CS",email,"123456"];
      if(lists[4]==password) {
        lists[0]="true";
        prefs.setStringList(reg_no, lists);
        navigateToAnotherScreen(context,lists[1],reg_no,lists[2],lists[3]);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password is not correct'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
      }
    }
  }

  void _forgotPassword(var context) async{

    //["true","Mohd vasil ansari","B.Tech CS",email,"123456"];

    var prefs=await SharedPreferences.getInstance();
    List<String> lists=prefs.getStringList(reg_no);
    String emails=lists[3];
    String get_password=_getRandomPassword();
    print(get_password);
    lists[4]=get_password;
    prefs.setStringList(reg_no,lists);

    Toast.show("Your new password is : $get_password", context,duration: 5,gravity: Toast.TOP,backgroundRadius: 40);

    send(lists[3],"Your new password for e-learnning App is $get_password for registration number $reg_no.Please do not share it with anyone.You can change passsword later on as per your need.","Password Recovery");

  }

  String _getRandomPassword(){
    int num=Random().nextInt(10000);
    int sp=Random().nextInt(2);
    List<String> special=["@","#"];
    String alphas="";
    for(int i=0;i<4;i++) {
      int alpha = Random().nextInt(26);
      alphas=alphas+String.fromCharCode(alpha+65);
    }
    String password=num.toString()+special[sp]+alphas;
    print("password : $password");
    return password;
  }

  void navigateToAnotherScreen(var context,var name,var reg_no,var branch,var email){
    Navigator.pushReplacement(context,PageTransition(child: AnotherScreen(name,reg_no,branch,email), type:PageTransitionType.topToBottom ));
  }
}

class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}
// ignore: must_be_immutable
class _SignUp extends State<Signup> {

  bool _show=false;

  static var _priorities = ['Select your branch','B.Tech CS', 'B.Tech EE'];
  var _prio=_priorities[0];

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      child: TextField(
                        obscureText: _show?false:true,
                        controller: passwordController1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      width: 300.0,
                    ),
                    Container(padding: EdgeInsets.all(3.0),),
                    SizedBox(
                      child :Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          child: Icon(_show?Icons.remove_red_eye:Icons.remove_red_eye_outlined,),
                          onPressed: (){
                            setState(() {
                              _show=!_show;
                            });
                          },
                        ),
                      ),
                      width: 50.0,
                    ),
                  ],
                ),
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      child: TextField(
                        obscureText: _show?false:true,
                        controller: passwordController2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Re-enter Password',
                        ),
                      ),
                      width: 300.0,
                    ),
                    Container(padding: EdgeInsets.all(3.0),),
                    SizedBox(
                      child :Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          child: Icon(_show?Icons.remove_red_eye:Icons.remove_red_eye_outlined,),
                          onPressed: (){
                            setState(() {
                              _show=!_show;
                            });
                          },
                        ),
                      ),
                      width: 50.0,
                    ),
                  ],
                ),
              )
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email id',
                ),
              ),
            ),
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String> (
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  style: kSendButtonTextStyle,
                  value: _prio,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      _prio=valueSelectedByUser;
                    });
                  }
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Sign Up'),
                  onPressed: () {
                    _getSignedUp();
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _getSignedUp() async{
    String name=nameController.text;
    String email=emailController.text;
    String password=passwordController1.text;
    String pass=passwordController2.text;
    String course=_prio;
    if(name.trim().length==0 || email.trim().length==0 || password.trim().length==0 || password!=pass ||
    course=='Select your branch'){
      Toast.show("Please complete all fields", context,duration: 2,gravity: Toast.CENTER);
    }
    else if(isValid(password, context)){
      var prefs=await SharedPreferences.getInstance();
      List<String> emails=prefs.getStringList("emails");
      if(emails.contains(email)){
        Toast.show("Email already exists", context,duration: 2,gravity: Toast.CENTER);
      }
      else {
        Toast.show("You are logged in Succcessfully", context, duration: 2,
            gravity: Toast.TOP);
        emails.add(email);
        prefs.setStringList("emails", emails);
        var key = generateReg(
            prefs.containsKey("reg") ? prefs.getString("reg") : null);
        prefs.setString("reg", key);
        List<String> user = ["true", name, course, email, password];
        prefs.setStringList(key, user);

        List<String> lists = [];
        if (user[2] == "B.Tech CS") {
          lists.addAll(getCSLists());
        }
        else if (user[2] == "B.Tech EE") {
          lists.addAll(getEELists());
        }
        for (String s in lists) {
          if (!prefs.containsKey(key + "_chances" + "_" + s)) {
            prefs.setInt(key + "_chances" + "_" + s, 2);
          }
        }
        Navigator.pushReplacement(context, PageTransition(
            child: AnotherScreen(user[1], key, user[2], user[3]),
            type: PageTransitionType.rightToLeft));
      }

    }
  }

  List<String> getCSLists(){
    return [
      'Software engineering',
      'C++ Programming',
      'java Programming',
      'Discrete Mathematics',
      'Introduction to programming using pythons',
      'Data Structures and Algorithms'
    ];
  }

  List<String> getEELists(){
    return [
      'Power Electronics',
      'Microcontroller',
      'Operating System',
      'Data Structures'
    ];
  }

  String generateReg(String s){
    if(s==null){
      return "20210001";
    }
    String str=(int.parse(s)+1).toString();
    return str;
  }

  bool isValid(String password,var context){
    if(password.length<5){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be of atleast 5 length.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(password.length>20){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password can be of atmost 20 length.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(password.contains(' ')){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should not contain spaces'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(isAlpha(password)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should contain atleast one number and one special character.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(isNumeric(password)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should contain atleast one lower case and one upper case character and one special character.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }
    else if(isAlphanumeric(password)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should contain atleast one special character.'),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    }else{
      return true;
    }
    return false;
  }
  void navigateToAnotherScreen(var context,var name,var reg_no,var branch,var email){
    Navigator.push(context,PageTransition(child: MainScreen(name,reg_no,branch,email), type:PageTransitionType.topToBottom ));
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_page_app/another_screen.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:page_transition/page_transition.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 5,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset(
          'images/splash.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}

class AfterSplash extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: RoundedButton(title: "Move To Another Screen",onPressed: () async {
          String email="vasilansari150@gmail.com";
          var prefs=await SharedPreferences.getInstance();
          var key=prefs.getString(email)!=null?prefs.getString(email):generateReg(prefs.containsKey("reg")?prefs.getString("reg"):null);
          prefs.setString("reg", key);
          List<String> user=["true","Mohd vasil ansari","B.Tech CS",email,"123456"];
          if(prefs.containsKey(key)){
            user=prefs.getStringList(key);
            user[0]="true";
            prefs.setStringList(key,user);
            print(prefs.getStringList(key));
          }else{
            prefs.setString(email, key);
            prefs.setStringList(key, user);
            print("prefs: "+prefs.getString(email));
            print(prefs.getStringList(key));
          }
          List<String> lists=[];
          if(user[2]=="B.Tech CS"){
            lists.addAll(getCSLists());
          }
          else if(user[2]=="B.Tech EE"){
            lists.addAll(getEELists());
          }
          for(String s in lists) {
            if (!prefs.containsKey(key + "_chances"+"_"+s)) {
              prefs.setInt(key + "_chances"+"_"+s, 2);
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('you are logged in successfully')));
          Navigator.push(context, PageTransition(child: AnotherScreen(user[1],key,user[2],user[3]), type: PageTransitionType.rightToLeft));
        },colour: Colors.blueAccent,),
      ),
    );
  }

  String generateReg(String s){
    if(s==null){
      return "20210001";
    }
    String str=(int.parse(s)+1).toString();
    return str;
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
}



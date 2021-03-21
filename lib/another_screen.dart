import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

class AnotherScreen extends StatelessWidget{

  String name;
  String registration_number;
  String branch;
  String email;
  AnotherScreen(this.name,this.registration_number,this.branch,this.email);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.amberAccent,
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(name,registration_number,branch,email));
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_page_app/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.amberAccent,
          primarySwatch: Colors.blue,
        ),
        home: MainScreen());
  }
}

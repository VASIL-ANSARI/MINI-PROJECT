import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'edit_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  String name, email, registration_number, branch;

  Details(this.name, this.email, this.registration_number, this.branch);

  @override
  State<StatefulWidget> createState() {
    return _DetailsState(name, email, registration_number, branch);
  }
}

class _DetailsState extends State<Details> {
  String name, email, registration_number, branch;

  _DetailsState(this.name, this.email, this.registration_number, this.branch);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title:Text("Details")),
        body:FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context,snapshot){
      if(!snapshot.hasData){
        return CircularProgressIndicator();
    }
      List<String> lists=snapshot.data.getStringList(registration_number);
      String _name=lists[1];
      String _branch=lists[2];
      String _email=lists[3];
      String _registration_number=registration_number;
      return Container(
        color: Colors.black,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top:20),
              child: Text(
                "Name: $_name",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              decoration: kMessageContainerDecoration,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top:20),
              child: Text(
                "Email: $_email",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              decoration: kMessageContainerDecoration,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top:20),
              child: Text(
                "Registration Number: $_registration_number",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              decoration: kMessageContainerDecoration,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top:20),
              child: Text(
                "Branch: $_branch",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              decoration: kMessageContainerDecoration,
            ),
            RoundedButton(onPressed: () async{
              var nav= await Navigator.push(context, PageTransition(child: EditDetailsScreen(name,email,registration_number,branch), type: PageTransitionType.scale));
              if(nav==true||nav==null){
                setState(() {
                });
              }
            },title: "Edit Details",colour: Colors.blueAccent,)
          ],
        ),
      );
    },
    )
      ),
    );
  }
}

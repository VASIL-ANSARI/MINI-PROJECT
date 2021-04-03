import 'package:flutter/material.dart';
import 'package:main_page_app/login.dart';
import 'package:main_page_app/main.dart';
import 'package:main_page_app/screens/end_screen.dart';
import 'package:main_page_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_password.dart';
import 'details.dart';

class MainDrawer extends StatelessWidget{
  List<String> Subjects = [];
  String name,branch,registration_number,email;
  GlobalKey<ScaffoldState> scaffoldKey;

  MainDrawer(this.name,this.branch,this.registration_number,this.email);

  @override
  Widget build(BuildContext context) {
    if(branch.toLowerCase()=="b.tech cs"){
      Subjects.addAll(getCSLists());
    }
    else if(branch.toLowerCase()=="b.tech ee"){
      Subjects.addAll(getEELists());
    }
    return Drawer(
      child:Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30,bottom: 10),
                    child: Center(child:Text(name.substring(0,1),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                    ))
                  ),
                  FutureBuilder<SharedPreferences>(future: SharedPreferences.getInstance(),
                  builder: (context,snapshot){
                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }
                    String _name=snapshot.data.getStringList(registration_number)[1];
                    return Text('Name: $_name',style: TextStyle(fontSize: 22,color: Colors.white),);
                  },),
                  Text('Registration number: $registration_number',style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile',style: TextStyle(fontSize: 18),),
            onTap: (){
              var nav=Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Details(name,email,registration_number,branch);
              }));
              if(nav==true || nav==null){
                build(context);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('View Result',style: TextStyle(fontSize: 18),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EndScreen(Subjects.length, Subjects,registration_number);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('Change Password',style: TextStyle(fontSize: 18),),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return ChangePassword(registration_number);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout',style: TextStyle(fontSize: 18),),
            onTap: () async{
              var prefs=await SharedPreferences.getInstance();
              var key=registration_number;
              List<String> user=[];
              if(prefs.containsKey(key)){
                user=prefs.getStringList(key);
                user[0]="false";
                prefs.setStringList(key,user);
                print(prefs.getStringList(key));
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('you are logged out successfully')));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }));
            },
          )

        ],
      )
    );
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
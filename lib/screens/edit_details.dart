import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDetailsScreen extends StatefulWidget {
  String name, email, registration_number, branch;

  EditDetailsScreen(
      this.name, this.email, this.registration_number, this.branch);

  @override
  State<StatefulWidget> createState() {
    return _EditDetailsState(name, email, registration_number, branch);
  }
}

class _EditDetailsState extends State<EditDetailsScreen> {
  String name, email, registration_number, branch;
  TextEditingController titleController;
  TextEditingController descriptionController;

  _EditDetailsState(
      this.name, this.email, this.registration_number, this.branch){
    titleController=TextEditingController(text: email);
    descriptionController = TextEditingController(text:name);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT DETAILS"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: titleController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                  _updateEmail();
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                keyboardType: TextInputType.name,
                controller: descriptionController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                  _updateName();
                },
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            // Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: RoundedButton(
                colour: Theme.of(context).primaryColorDark,
                title: 'Save',
                onPressed: () {
                  setState(() {
                    debugPrint("Save button clicked");
                    _save();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateName() {
    name = descriptionController.text;
  }

  void _updateEmail() {
    email = titleController.text;
  }

  void _save() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(registration_number);
    List<String> emails=prefs.getStringList("emails");
    //["true","Mohd vasil ansari","B.Tech CS",email,password]
    if(name.trim().length==0){
      if(email.trim().length>0 && emails.contains(email)){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Email already exists!"),
          backgroundColor: Colors.red,
        ));
        return ;
      }
      else if(email.trim().length>0){
        list[3]=email;
      }
    }
    else if(email.trim().length==0){
      if(name.trim().length>0){
        list[1]=name;
      }
    }else {
      if(emails.contains(email)){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Email already exists!"),
          backgroundColor: Colors.red,
        ));
        return ;
      }
      else{
        list[1]=name;
        list[3]=email;
      }
    }
    prefs.setStringList(registration_number, list).whenComplete(() {
      Navigator.pop(context,true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Details Saved!"),
        backgroundColor: Colors.green,
      ));
    });
  }
}

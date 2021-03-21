import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget{
  String reg;
  ChangePassword(this.reg);
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordState(reg);
  }
}

class _ChangePasswordState extends State<ChangePassword>{
  String reg,OldPassword="",NewPassword="",AnotherNewPassword="";
  _ChangePasswordState(this.reg);

  TextEditingController OldController = TextEditingController();
  TextEditingController NewController = TextEditingController();
  TextEditingController ReNewController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: OldController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                  _updateOldField();
                },
                decoration: InputDecoration(
                    labelText: 'Enter Old Password',
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
                keyboardType: TextInputType.visiblePassword,
                controller: NewController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: (value) {
                  //debugPrint('Something changed in Description Text Field');
                  _updateNewField();
                },
                decoration: InputDecoration(
                    labelText: 'Enter New Password',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: ReNewController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: (value) {
                  //debugPrint('Something changed in Description Text Field');
                  _updateAnotherNewField();
                },
                decoration: InputDecoration(
                    labelText: 'Re-Enter New Password',
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

  void _updateOldField(){
    OldPassword=OldController.text;
  }

  void _updateAnotherNewField(){
    AnotherNewPassword=ReNewController.text;

  }

  void _updateNewField(){
    NewPassword=NewController.text;
  }

  void _save() async{
    var prefs=await SharedPreferences.getInstance();
    List<String> lists=prefs.getStringList(reg);
    print("old:"+OldPassword);
    print("new:"+NewPassword);
    print("Another New:"+AnotherNewPassword);
    //["true","Mohd vasil ansari","B.Tech CS",email,"123456"];
    if(OldPassword.trim()==''){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Old Password!"),
        backgroundColor: Colors.red,
      ));
    }
    else if(OldPassword!=lists[4]){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Old Password Not Correct!"),
        backgroundColor: Colors.red,
      ));
    }
    else if(NewPassword.trim()==''){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("New Password Cannot be empty."),
        backgroundColor: Colors.red,
      ));
    }
    else if(AnotherNewPassword!=NewPassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please re-enter correct password."),
        backgroundColor: Colors.red,
      ));
    }
    else if(lists[4]==OldPassword && NewPassword==AnotherNewPassword){
      lists[4]=NewPassword;
      prefs.setStringList(reg,lists).whenComplete((){
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password Changed Successfully!"),
          backgroundColor: Colors.green,
        ));
      });
    }
  }
}
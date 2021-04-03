import 'package:flutter/material.dart';
import 'package:main_page_app/components/rounded_btn.dart';
import 'package:main_page_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class ChangePassword extends StatefulWidget {
  String reg;

  ChangePassword(this.reg);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordState(reg);
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _show = false;
  String reg, OldPassword = "", NewPassword = "", AnotherNewPassword = "";

  _ChangePasswordState(this.reg);

  TextEditingController OldController = TextEditingController();
  TextEditingController NewController = TextEditingController();
  TextEditingController ReNewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Password"),
          leading: FlatButton(child:Icon(Icons.arrow_back_rounded,color: Colors.black,),onPressed: (){
            _back();
          },color: AppBarTheme.of(context).color,)
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child:SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _show?false:true,
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

              // Third Element
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _show?false:true,
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
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child:SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _show?false:true,
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
      ),
    );
  }

  void _updateOldField() {
    OldPassword = OldController.text;
  }

  void _updateAnotherNewField() {
    AnotherNewPassword = ReNewController.text;
  }

  void _updateNewField() {
    NewPassword = NewController.text;
  }

  void _back() async{
    var prefs = await SharedPreferences.getInstance();
    List<String> lists = prefs.getStringList(reg);
    moveToLastScreen(lists[1],reg,lists[2],lists[3]);
  }

  void _save() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> lists = prefs.getStringList(reg);
    print("old:" + OldPassword);
    print("new:" + NewPassword);
    print("Another New:" + AnotherNewPassword);
    //["true","Mohd vasil ansari","B.Tech CS",email,"123456"];
    if (OldPassword.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Old Password!"),
        backgroundColor: Colors.red,
      ));
    } else if (OldPassword != lists[4]) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Old Password Not Correct!"),
        backgroundColor: Colors.red,
      ));
    } else if (NewPassword.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("New Password Cannot be empty."),
        backgroundColor: Colors.red,
      ));
    } else if (AnotherNewPassword != NewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please re-enter correct password."),
        backgroundColor: Colors.red,
      ));
    } else if (lists[4] == OldPassword &&
        NewPassword == AnotherNewPassword &&
        isValid(NewPassword, context)) {
      lists[4] = NewPassword;
      prefs.setStringList(reg, lists).whenComplete(() {
        moveToLastScreen(lists[1],reg,lists[2],lists[3]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password Changed Successfully!"),
          backgroundColor: Colors.green,
        ));
      });
    }
  }

  bool isValid(String password, var context) {
    if (password.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password must be of atleast 5 length.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (password.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password can be of atmost 20 length.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (password.contains(' ')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password should not contain spaces'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (isAlpha(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Password should contain atleast one number and one special character.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (isNumeric(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Password should contain atleast one lower case and one upper case character and one special character.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else if (isAlphanumeric(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password should contain atleast one special character.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else {
      return true;
    }
    return false;
  }

  void moveToLastScreen(String name,String reg_no,String branch,String email) {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
      return MainScreen(name,reg_no,branch,email);
    }));
  }
}

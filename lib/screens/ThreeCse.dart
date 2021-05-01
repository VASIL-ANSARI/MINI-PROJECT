import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class ThreeCSE extends StatefulWidget {
  ThreeCSE({Key key}) : super(key: key);

  @override
  _ThreeCSEState createState() => _ThreeCSEState();
}

class _ThreeCSEState extends State<ThreeCSE> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1ACcuFtqhazAkDJkojpIQYDIEzlAups2A/view?usp=sharing')
              },
              child: const Text('Computer Organization and Architecture'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
               _launchURLApp('https://drive.google.com/file/d/1sYBj3M1MYIJX7pLVSuO-plnTptRXeE8x/view?usp=drivesdk')
              },
              child: const Text('Operating Systems'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1zokKrq9VClZbwjf9Kx2O_wT-rrMZV8Z_/view?usp=drivesdk')
              },
              child: const Text('Database Management Systems'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1Fmk9CoVHdbsrKUbXaeBMGvzousRtLym0/view?usp=drivesdk')
              },
              child: const Text('Computer Networking'),
            ),
          ],
        ),
      ),
    );
  }

  _launchURLApp(url) async {
    if (await canLaunch(url)) {
      await launch(url,forceWebView: true,forceSafariVC: true,enableJavaScript: true);
    } else {
      Toast.show('Could not launch $url', context, duration: 2,
          gravity: Toast.TOP);
      throw 'Could not launch $url';
    }
  }
}
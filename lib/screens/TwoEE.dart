import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';


class TwoEEE extends StatefulWidget {
  TwoEEE({Key key}) : super(key: key);

  @override
  _TwoEEEState createState() => _TwoEEEState();
}

class _TwoEEEState extends State<TwoEEE> {
  
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
               _launchURLApp('https://drive.google.com/file/d/1mJgfbnh9q4KLoULRuR-ty68RNc4yyoH-/view?usp=drivesdk')
              },
              child: const Text('Basic Electrical Engineering'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
               _launchURLApp('https://drive.google.com/file/d/1_xDCeSzMTVkPxedo6SEU-JhDTf9lusfT/view?usp=drivesdk')
              },
              child: const Text('Electromagnetic Field Theory'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1fRcBBD-GcpOtZWwtacZTFV42R5cPzAOm/view?usp=drivesdk')
              },
              child: const Text('Power Systems'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1Nre5HNPPRW9Nm_oRjcOZNN-pE0IPouAo/view?usp=drivesdk')
              },
              child: const Text('Signal Systems'),
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
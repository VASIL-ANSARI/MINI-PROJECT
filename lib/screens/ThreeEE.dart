import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class ThreeEEE extends StatefulWidget {
  ThreeEEE({Key key}) : super(key: key);

  @override
  _ThreeEEEState createState() => _ThreeEEEState();
}

class _ThreeEEEState extends State<ThreeEEE> {

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
                _launchURLApp('https://drive.google.com/file/d/1OYxvtepHIAaNUnW75TDo2ZojnwGjnaZE/view?usp=drivesdk')
              },
              child: const Text('Embedded Systems'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1bKGaaZFxFa2hjB8KeTrgk7bEjQbRJWEN/view?usp=drivesdk')
              },
              child: const Text('Communication Theory'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1ACcuFtqhazAkDJkojpIQYDIEzlAups2A/view?usp=sharing')
              },
              child: const Text('Computer Organisation and Architecture'),
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
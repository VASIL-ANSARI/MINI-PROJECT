import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';


class TwoCSE extends StatefulWidget {
  TwoCSE({Key key}) : super(key: key);

  @override
  _TwoCSEState createState() => _TwoCSEState();
}

class _TwoCSEState extends State<TwoCSE> {
  // This moves the PDF file from the assets to a place accessible by our PDF viewer.
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
                _launchURLApp('https://drive.google.com/file/d/1YTsiYoYIK_u-kxwOdhT2DYs78L6UO52L/view?usp=drivesdk')
              },
              child: const Text('Data Structures and Algorithms'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1cqD19ogkYszDTIeNypIuwPkQ2b6fn-Kj/view?usp=drivesdk')
              },
              child: const Text('Object Oriented Programming'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp('https://drive.google.com/file/d/1HHfrA4ZKiqi7A8mNlYvbYj3PsA6TW5CI/view?usp=drivesdk')
              },
              child: const Text('Discrete Mathematics'),
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
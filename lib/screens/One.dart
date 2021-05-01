import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class One extends StatefulWidget {
  One({Key key}) : super(key: key);

  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  Timer _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          print('Timer : $_start');
          _start++;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                _launchURLApp(
                    'https://drive.google.com/file/d/15WjHtIU31mXYjdK_U5R7c5T2gtufDWUJ/view?usp=drivesdk')
              },
              child: const Text('Mathematics'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp(
                    'https://drive.google.com/file/d/1QQS_wm30NILQi31_24p910_4r8Ut1YAF/view?usp=drivesdk')
              },
              child: const Text('Physics'),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () => {
                _launchURLApp(
                    'https://drive.google.com/file/d/1__ErhzxeIE3JLvYBVwI5t7A9kTL7QlsB/view?usp=gmail')
              },
              child: const Text('C Programming'),
            ),
          ],
        ),
      ),
    );
  }

  _launchURLApp(url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, forceSafariVC: true, enableJavaScript: true);
    } else {
      Toast.show('Could not launch $url', context,
          duration: 2, gravity: Toast.TOP);
      throw 'Could not launch $url';
    }
  }
}

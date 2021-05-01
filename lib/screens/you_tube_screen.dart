import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtube extends StatefulWidget {
  Youtube({ this.title, this.url});
  final String title;
  final url;

  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          controlsVisibleAtStart: true,
          isLive: false,
          autoPlay: false,
        )
    );
  }

  @override
  void initState(){
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkConnectivity();
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                player,
                SizedBox(height: 40.0),
              ],
            ),
          ),
        );
      },
    );
  }

  void checkConnectivity() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Toast.show('It requires network connectivity but you are not connected to internet.Please connect and try again!', context,gravity: Toast.BOTTOM,duration: 5);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';


class Video extends StatefulWidget {
  @override
  _VideoState createState() => new _VideoState();
}

class _VideoState extends State<Video> {

  void playYoutubeVideo() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "AIzaSyB12TqCJKG4T76Ec4hdlYTQIc33Assrp2A",
      videoUrl: "https://www.youtube.com/watch?v=wgTBLj7rMPM",
      autoPlay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    playYoutubeVideo();
    return Container();
  }
}
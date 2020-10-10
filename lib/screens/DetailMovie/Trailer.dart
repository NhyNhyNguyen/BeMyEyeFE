//import 'package:bymyeyefe/constant/StyleConstant.dart';
//import 'package:flutter/material.dart';
//import 'package:youtube_player/youtube_player.dart';
//
//class Trailer extends StatefulWidget {
//  String trailer;
//  Trailer(this.trailer);
//  @override
//  _Trailer createState() => _Trailer(trailer);
//}
//
//class _Trailer extends State<Trailer> {
//  String trailer;
//  _Trailer(this.trailer);
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.only(left: 15),
//          child: Text("Trailer", style:StyleConstant.bigTxtStyle ,),
//        ),
//        YoutubePlayer(
//
//          source: trailer,
//          //source: "https://www.youtube.com/watch?v=NyTOHJW1PIE",
//          quality: YoutubeQuality.HD,
//          aspectRatio: 16 / 9,
//        ),
//      ],
//    );
//  }
//}
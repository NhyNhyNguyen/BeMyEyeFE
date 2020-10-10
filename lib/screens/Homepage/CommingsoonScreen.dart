import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:bymyeyefe/screens/Homepage/BannerImage.dart';
import 'package:bymyeyefe/screens/Homepage/CategoryMovie.dart';
import 'package:bymyeyefe/screens/Homepage/NowshowingScreen.dart';
import 'package:bymyeyefe/screens/News/News.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import '../../constant/ColorConstant.dart';
import '../ButtonGradient.dart';
import 'OptionTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommingsoonScreen extends StatefulWidget {
  @override
  _CommingsoonScreen createState() => _CommingsoonScreen();
}

class _CommingsoonScreen extends State<CommingsoonScreen>  {
  String type = "coming-soon";

//  String url;
//  List<Movie> data;

  void choseOption(type) {
    setState(() {
      this.type = type;
    });
  }

  @override
  void initState() {
    String url  = UrlConstant.URL_FILM + 'coming-soon';
    {
      http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
      }).then((http.Response response) {
        setState((){
          data = new List<Movie>();
          json.decode(response.body).forEach((json) {
            data.add(Movie.fromJson(json));
          });
        });
      });
      print('333');
    };
  }

  @override
  Widget build(BuildContext context) {

    return (type == 'coming-soon')
        ? MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          child: Column(
            children: <Widget>[
              Container(
                //height: 500,
                height: MediaQuery.of(context).size.height * 0.77,
                child: ListView(
                  children: <Widget>[
                    BannerImage(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 10.0),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ButtonGradient(
                              type,
                              "now-showing",
                              StringConstant.NOW_SHOWING,
                                  () => choseOption("now-showing")),
                          ButtonGradient(
                              type,
                              "coming-soon",
                              StringConstant.COMMING_SOON,
                                  () => choseOption("coming-soon")),
                        ],
                      ),
                    ),
                    //OptionTab('now-showing'),
                    Container(
                      // height: 435,
                        height: MediaQuery.of(context).size.height * 0.675,
                        child: CategoryMovie(type)),

//                      Container(
//                         // height: 435,
//                          height: MediaQuery.of(context).size.height * 0.675,
//                          child: MyHomepage()),
                    //MyHomepage(),
                  ],
                ),
              )
            ],
          ),

        )
        ,
        "HOME", "Home")
        : NowshowingScreen()
    ;
  }
}

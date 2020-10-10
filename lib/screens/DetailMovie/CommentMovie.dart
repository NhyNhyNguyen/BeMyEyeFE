import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/screens/DetailMovie/CommentInput.dart';
import 'package:bymyeyefe/screens/DetailMovie/CommentItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentMovie extends StatefulWidget {
  String idMovie;
  CommentMovie(this.idMovie);
  @override
  CommentMovieState createState() => CommentMovieState(idMovie);
}

class CommentMovieState extends State<CommentMovie> {

  String idMovie;
  CommentMovieState(this.idMovie);


  List<dynamic> data;
  @override
  Widget build(BuildContext context) {

    String url  = UrlConstant.URL_COMMENT + idMovie;
    if (data == null) {
      http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
      }).then((http.Response response) {
        if(mounted) {
          setState(() => data = json.decode(response.body));
        }
      });
    };
    if (data == null) return Container(
      child: Icon(Icons.cached, color: ColorConstant.GRAY_TEXT, size: 50,),
    );
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 4.5,
              children:
              data.map(
                (item) =>CommentItem(item["avatarUser"], item["fullNameUser"], item["content"], item["timeCreate"])
              ).toList()
              ),

          ),
        ],
      ),
    );
  }
}

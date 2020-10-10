import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/screens/DetailMovie/DetailMovieScreen.dart';
import 'package:bymyeyefe/screens/User/ChoosePage.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatingMovieDialog extends StatefulWidget {
  String idMovie;
  int lastRate;
  RatingMovieDialog (this.lastRate, this.idMovie);
  @override
  _RatingMovieDialogState createState() => _RatingMovieDialogState(lastRate, idMovie);
}

class _RatingMovieDialogState extends State<RatingMovieDialog> {
  String idMovie;
  int lastRate;
  _RatingMovieDialogState (this.lastRate, this.idMovie);
  static dynamic data;
  //int lastRate = id;

  Future<http.Response> putRate(int rate) async {
    print("hello rate");
    final http.Response response = await http.put(
      UrlConstant.URL_PUT_RATE + idMovie + "/rate",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization':
        'Bearer ' + ConstantVar.jwt,
      },
      body: jsonEncode(<String, int>{
        "point": rate,
      }),
    );
    print(idMovie);
    print(rate);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailMovieScreen(idMovie)));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginScreen(handel: "")));
    }
    return response;
  }


  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        size: 30.0,
        color: lastRate >= starCount ? Colors.orangeAccent : ColorConstant.GRAY_TEXT,
      ),
      onTap: () {
        setState(() {
          lastRate = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //get_rate();
    return AlertDialog(
      title: Center(child: Text('Rate this movie', style: TextStyle(fontSize: 25),),),
      content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildStar(1),
                  _buildStar(2),
                  _buildStar(3),
                  _buildStar(4),
                  _buildStar(5),
                ],
              ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            putRate(lastRate);
          },
        )
      ],
    );
  }
}
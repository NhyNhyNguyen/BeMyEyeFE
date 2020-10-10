
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'dart:math' as math;

import 'ShowtimeMovieItem.dart';

class CategoryShowtimeMovie extends StatefulWidget{
  final int duration;
  CategoryShowtimeMovie(this.duration);
  @override
  _CategoryShowtimeMovieState createState() => _CategoryShowtimeMovieState(duration);
}

class _CategoryShowtimeMovieState extends State<CategoryShowtimeMovie>  {
  final int duration;
  _CategoryShowtimeMovieState(this.duration);

  DateTime date = DateTime.now();
  String url;
  List<dynamic> data;

  String _getDatefromDuration(int duration){
    DateTime newDate = date.add(Duration(days: duration));
    String dd = DateFormat('dd').format(newDate).toString();
    String mm = DateFormat('MM').format(newDate).toString();
    String yyyy = DateFormat('yyyy').format(newDate).toString();
    String dateShowtime = dd + "/" + mm + "/" + yyyy;
    print(dateShowtime);
    return dateShowtime;
  }

  List<dynamic> _getData(int duration) {
    //_getDatefromDuration(duration);
    url = UrlConstant.URL_GET_SHOWTIME + _getDatefromDuration(duration);
    if(data==null){
      http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
      }).then((http.Response response) {
        setState(() => data = json.decode(response.body) );
      });
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    _getData(duration);
    if (data == null) return Container(
      child:         Stack(
        children: <Widget>[
          Container(
            color: ColorConstant.VIOLET,
            width: double.infinity,
            height: double.infinity,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 50, height: 50,
                    child:  CircularProgressIndicator(
                      strokeWidth: 4,
                      backgroundColor: Colors.white,
                      valueColor: new AlwaysStoppedAnimation<Color>(ColorConstant.LIGHT_VIOLET),
                    )
                )
              ],
            ),
          )

        ],
      )
      ,
      //child: Text('hien chua co lich chieu', style: TextStyle(color: ColorConstant.GRAY_TEXT),)
    )
    ;
    if( data.length == 0) return Container(
      //child: Icon(Icons.cached, color: ColorConstant.GRAY_TEXT, size: 50,),
      child: Column(
        children: <Widget>[
          Image.asset(ImageConstant.CAMERA, height: 270),
          Text('Showtimes aren\'t available!', style: TextStyle(color: ColorConstant.GRAY_TEXT,  fontSize: 20),),
        ],
      )
    )
    ;

    return GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 1.6,
        children:
        data.map(
                (item) =>ShowtimeMovieItem(_getDatefromDuration(duration), item['film']['id'],item['film']['name'], item['film']['poster'], item['film']['genres'], item['film']['filmDescription']['timeLimit'], item['time'])
        ).toList()
    );

  }
}









import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'BannerImage.dart';
import 'MovieItem.dart';
import 'OptionTab.dart';
import 'dart:math' as math;

class CategoryMovieSearch extends StatefulWidget {
  String keyword;
  CategoryMovieSearch(this.keyword);

  @override
  _CategoryMovieSearchState createState() => _CategoryMovieSearchState(keyword);
}

class _CategoryMovieSearchState extends State<CategoryMovieSearch>  {
  String keyword;
  _CategoryMovieSearchState(this.keyword);

  String url;
  List<dynamic> data;
List<Movie> _getData(String keyword){
  url  = UrlConstant.URL_SEARCH + keyword;
  if(data==null){
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
    print('444');
  };
}



  @override
  Widget build(BuildContext context) {
    _getData(keyword);

    if (data == null) return Container(
      child:Stack(
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
    );
    if (data.length == 0) return Container(
      //child: Image.asset(ImageConstant.CAMERA, height: 100),
      child: Text("khong co phim phu hop"),
    );
    return GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 1.4,
        children:
        data.map(
                (item) =>MovieItem(item.id.toString(), item.name, item.poster, item.genres)
        ).toList()
    );

  }
}








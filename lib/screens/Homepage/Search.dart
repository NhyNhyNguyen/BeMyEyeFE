import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CategoryMovieSearch.dart';
import 'MovieItem.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _keySearch = GlobalKey<FormState>();
  TextEditingController controlSearch = TextEditingController();

  String keyword ="";

  String url;
  List<Movie> data;

  List<Movie> _getData(String keyword){
    url  = UrlConstant.URL_SEARCH + keyword;
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
      print('444');
    };
  }

  @override
  void initState() {
  _getData("a");
    //super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          child: Column(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).size.height * 0.1 ,
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Form(
                        key: _keySearch,
                        child: TextFormField(
                          style: TextStyle(color: ColorConstant.GREY),
                          decoration: InputDecoration(
                            enabledBorder: StyleConstant.enabledBorder,
                            focusedBorder: StyleConstant.focusedBorder,
                            hintText: "What are you searching?",
                            hintStyle: TextStyle(color: ColorConstant.GREY,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            border: InputBorder.none,
                          ),
                          controller: controlSearch,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, size: 40, color: ColorConstant.GRAY_TEXT,),
                      padding: EdgeInsets.all(5),
                      onPressed: () {setState(() {
                        keyword = controlSearch.text;
                      });
                      controlSearch.clear();},
                    )
                  ],
                ),
              ),
               Container(
                 height:MediaQuery.of(context).size.height * 0.63 ,
                 child: ListView(
                    children: <Widget>[ Container(
                        // height: 435,
                         height: MediaQuery.of(context).size.height * 0.6,
                         child: CategoryMovieSearch(keyword)),
                    ],
                  ),
               ),

            ],
          ),
        ),
        "HOME", "Search");
  }
}

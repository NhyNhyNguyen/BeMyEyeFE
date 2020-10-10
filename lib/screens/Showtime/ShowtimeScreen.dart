import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:bymyeyefe/screens/Homepage/BannerImage.dart';
import 'package:bymyeyefe/screens/Homepage/CategoryMovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:intl/intl.dart';
import '../../constant/ColorConstant.dart';
import 'package:bymyeyefe/screens/Homepage/Homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CategoryShowtimeMovie.dart';
import 'DateItem.dart';
import 'Showtime.dart';

class ShowtimeScreen extends StatefulWidget {
  @override
  _ShowtimeScreenState createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen>  {
  int dateSelected = 0;
  DateTime date = DateTime.now();
  List<int> listDuration = [0, 1, 2, 3, 4, 5, 6];

  String url;
  List<dynamic> data;

  List<dynamic> _getData(int duration) {
    DateTime newDate = date.add(Duration(days: duration));
    String dd = DateFormat('dd').format(newDate).toString();
    String mm = DateFormat('MM').format(newDate).toString();
    String yyyy = DateFormat('yyyy').format(newDate).toString();
    String dateShowime = dd + "/" + mm + "/" + yyyy;
    print(dateShowime);
    url = UrlConstant.URL_GET_SHOWTIME + dateShowime;
    {
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
  void initState() {
    _getData(0);
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
                height: 65,
                margin: EdgeInsets.all(10),
                //padding: EdgeInsets.only(top: 8, left: 20),
                decoration: BoxDecoration(
                    color: ColorConstant.LIGHT_VIOLET,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: GridView.count(
                    crossAxisCount: 7,
                    childAspectRatio: 0.75,
                    children:
                    listDuration.map(
                          (item) =>
                          InkWell(
                              onTap: () {
                                setState(() {
                                  dateSelected = item;
                                });
                              },
                              child: DateItem( item, dateSelected)),
                    ).toList()
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: CategoryShowtimeMovie(dateSelected),
              ),

            ],
          ),

        )
        ,
        "CAL", "Calendar");
  }
}

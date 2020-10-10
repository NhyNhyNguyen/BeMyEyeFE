import 'dart:convert';
import 'dart:math';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/Date.dart';
import 'package:bymyeyefe/model/DateTimeShowFilm.dart';
import 'package:bymyeyefe/model/Seat.dart';
import 'package:bymyeyefe/screens/Booking/RoomType.dart';
import 'package:bymyeyefe/screens/Booking/SeatMap.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:bymyeyefe/screens/User/Avatar.dart';
import 'package:bymyeyefe/screens/User/ChoosePage.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import '../../modal.dart';

class BookingTicket extends StatefulWidget {
  final int filmId;
  final String name;
  final String poster;

  BookingTicket({Key key, this.filmId, this.name, this.poster})
      : super(key: key);

  @override
  _BookingTicketState createState() =>
      _BookingTicketState(this.filmId, this.name, this.poster);
}

class _BookingTicketState extends State<BookingTicket> {
  List<DateTimeShowFilm> data = null;
  bool isLoading = true;
  final int filmId;
  final String name;
  final String poster;
  int selected = 0;
  int timeSelected = 0;
  List<String> listDayOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  _BookingTicketState(this.filmId, this.name, this.poster);

  @override
  void initState() {
    print("film id" + filmId.toString());
    fetchShowTimeFilm().then((value) => setState(() {}));
  }

  Future<bool> fetchShowTimeFilm() async {
    print(UrlConstant.SHOW_TIME_FILM + "?filmId=$filmId");
    final response = await http
        .get(UrlConstant.SHOW_TIME_FILM + "?filmId=$filmId", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then pCarse the JSON
      setState(() {
        data = new List<DateTimeShowFilm>();
        json.decode(response.body).forEach((json) {
          List<String> time = [];
          json['timeList'].forEach((e) {
            time.add(e);
          });
          data.add(DateTimeShowFilm(json['date'], time));
          print("show time film $filmId" + data.toString());
        });
        int idate = 0;
        if(data.length > 0){
          idate = int.parse(data[data.length - 1].date.substring(5, 7));
        }

        while (data.length < 7 && data.length != 0) {
          String d = data[data.length - 1].date;
          String t = d.substring(0, 3);
          int iday = Date().getCodeByString(t.toLowerCase());
          iday++;
          if (iday > 6) {
            iday = 0;
          }
          idate++;
          if(idate > 30)
            idate = idate -30;
          String sDate;
          if(idate < 10){
            sDate = '0' + idate.toString();
          }else{
            sDate = idate.toString();
          }

          data.add(DateTimeShowFilm(
              listDayOfWeek[iday] +
                  ", " +
                  (sDate).toString() +
                  d.substring(7),
              []));
        }
      });
      return true;
    } else {
      // If the server did not return a 200 K response,
      // then throw an exception.
      Modal.showSimpleCustomDialog(context, "Not found", "ck");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? data.length > 0
            ? MainLayOut.getMailLayout(
                context,
                Container(
                  color: ColorConstant.VIOLET,
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Avatar(
                            imageUrl: UrlConstant.IMAGE + poster,
                            username: name,
                            email: null),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(data[selected].date,
                                  style: StyleConstant.formTextStyle),
                              SizedBox(
                                height: 13,
                              ),
                              Container(
                                  height: 85,
                                  width:
                                      MediaQuery.of(context).size.height * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.LIGHT_VIOLET,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0, 15),
                                            blurRadius: 15),
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0, -10),
                                            blurRadius: 10)
                                      ]),
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          width: 62,
                                          height: 60,
                                          decoration: selected == index
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                  gradient: ColorConstant
                                                      .RAINBOW_BUTTON,
                                                )
                                              : BoxDecoration(),
                                          child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                selected = index;
                                              });
                                            },
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    data[index]
                                                        .date
                                                        .substring(5, 7),
                                                    style: StyleConstant
                                                        .formTextStyle,
                                                  ),
                                                  Text(
                                                    data[index]
                                                        .date
                                                        .substring(0, 3),
                                                    style: StyleConstant
                                                        .moreSmallTextStyle,
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    },
                                  )),
                              data[selected].time.length != 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Text("Time Showing",
                                            style: StyleConstant.formTextStyle),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.0, vertical: 5.0),
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorConstant.LIGHT_VIOLET,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(0, 15),
                                                      blurRadius: 15),
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(0, -10),
                                                      blurRadius: 10)
                                                ]),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.23,
                                                  child: ListView.builder(
                                                    itemCount: data[selected]
                                                        .time
                                                        .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.21,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 3,
                                                                  right: 3),
                                                          decoration: timeSelected ==
                                                                  index
                                                              ? BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)),
                                                                  gradient:
                                                                      ColorConstant
                                                                          .RAINBOW_BUTTON,
                                                                )
                                                              : BoxDecoration(),
                                                          child: FlatButton(
                                                            onPressed: () => {
                                                              setState(() {
                                                                timeSelected =
                                                                    index;
                                                              })
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    data[selected]
                                                                        .time[
                                                                            index]
                                                                        .substring(
                                                                            0,
                                                                            5),
                                                                    style: StyleConstant
                                                                        .btnSelectedStyle,
                                                                  ),
                                                                  Text(
                                                                    data[selected]
                                                                        .time[
                                                                            index]
                                                                        .substring(
                                                                            6),
                                                                    style: StyleConstant
                                                                        .normalTextStyle,
                                                                    maxLines: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            ButtonGradientLarge(
                                                StringConstant.CHOOSE_YOUR_SEAT,
                                                () => {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => SeatMap(
                                                                  filmId:
                                                                      filmId,
                                                                  dateTime: data[
                                                                              selected]
                                                                          .date
                                                                          .substring(
                                                                              5)
                                                                          .toString() +
                                                                      " " +
                                                                      data[selected]
                                                                          .time[
                                                                              timeSelected]
                                                                          .toString(),
                                                                  filmName:
                                                                      name)))
                                                    }),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(ImageConstant.CAMERA,
                                              height: 270),
                                          Text(
                                            'Showtimes aren\'t available!',
                                            style: TextStyle(
                                                color: ColorConstant.GRAY_TEXT,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                "USER",
                "Choose Time")
            : MainLayOut.getMailLayout(
                context,
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: ColorConstant.VIOLET,
                    child: Column(
                      children: <Widget>[
                        Avatar(
                            imageUrl: UrlConstant.IMAGE + poster,
                            username: name,
                            email: null),
                        Image.asset(ImageConstant.CAMERA, height: 270),
                        Text(
                          'Showtimes aren\'t available!',
                          style: TextStyle(
                              color: ColorConstant.GRAY_TEXT, fontSize: 20),
                        ),
                      ],
                    )),
                "CAL",
                "Choose time")
        : Loading(type: "CAL", title: "Choose time");
  }
}

import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/Seat.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/Booking/Poster.dart';
import 'package:bymyeyefe/screens/ButtonGradient.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:bymyeyefe/screens/Homepage/BannerImage.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/History.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../modal.dart';

class OrderTicket extends StatefulWidget {
  final int filmId;
  final String filmName;
  final List<String> seats;
  final String showTime;

  OrderTicket({Key key, this.filmId, this.filmName, this.seats, this.showTime})
      : super(key: key);
  @override
  _OrderTicketState createState() =>
      _OrderTicketState(this.filmId, this.filmName, this.seats, this.showTime);
}

class _OrderTicketState extends State<OrderTicket> {
  final int filmId;
  final String filmName;
  final List<String> seats;
  final String showTime;

  _OrderTicketState(this.filmId, this.filmName, this.seats, this.showTime);

  List<String> title = [ "SHOW TIME", "SEATS"];
  List<String> content = [
    "Chiec la cuon bay",
    "9:00 PM Tue 22/2/2020",
    "F1, F2 & F3"
  ];

  Future<http.Response> postOrderTicket(BuildContext context) async {
    final http.Response response = await http.post(
      UrlConstant.POST_BOOK,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + ConstantVar.jwt,
      },
      body: jsonEncode(
          {"filmId": filmId.toString(), "showTime": showTime, "seat": seats}),
    );

    print(json.encode(response.body));
    if (response.statusCode == 200) {
      Modal.showSimpleCustomDialog(context, "Your booking have send to your mail", null);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => History()));
    } else {
      if (response.statusCode == 403) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen(handel: "")));
      }else{
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => History()));
      }
    }
    return response;
  }

  var filmDetail = null;
  Future<bool> fetchFilmDetail(String jwt) async {
    if (jwt != "" || jwt != null) {
      final response =
          await http.get(UrlConstant.URL_FILM + "$filmId", headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $jwt',
      });
      print(json.decode(response.body));

      if (response.statusCode == 200) {
        filmDetail = json.decode(response.body);
        return true;
      } else {
        if (response.statusCode == 403) {
          ConstantVar.isLogin = false;
          ConstantVar.userDetail = null;
        }
        return false;
      }
    } else {
      Modal.showSimpleCustomDialog(context, "Not found", "");
    }
    return false;
  }
  String listGenres="";


  @override
  void initState() {
    fetchFilmDetail(ConstantVar.jwt).then((value) => setState(() {
          content = [];
          content.add(showTime);
          content.add(seats.join(", "));

          listGenres="";
          for(var item in filmDetail['genres']){
            listGenres = listGenres + ", " + item['name'];
            print(item['name']);
          }
          listGenres = listGenres.substring(2);
        }));
  }

  double infoHeight;
  double priceHeight;
  @override
  Widget build(BuildContext context) {
    infoHeight = MediaQuery.of(context).size.height * 0.38;
    priceHeight = MediaQuery.of(context).size.height * 0.373;
    return filmDetail != null
        ? MainLayOut.getMailLayout(
            context,
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorConstant.VIOLET,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: infoHeight,
                          decoration: BoxDecoration(
                              color: ColorConstant.LIGHT_VIOLET,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: priceHeight,
                          decoration: BoxDecoration(
                              color: ColorConstant.LIGHT_VIOLET,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  filmDetail['name'],
                                  style: StyleConstant.headerTextStyle,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                listGenres,
                                style: StyleConstant.normalTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: title
                                      .map((e) => Container(
                                            height: 50,
                                            padding: EdgeInsets.all(5),
                                            child: Text(e,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Open Sans",
                                                )),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10, bottom: 10, top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: content
                                      .map((e) => Container(
                                            height: 60,
                                    width: MediaQuery.of(context).size.width * 0.28,
                                            child: Text(e,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Open Sans",
                                                ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            padding: EdgeInsets.all(5),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Poster(
                                imageUrl:
                                    UrlConstant.IMAGE + filmDetail['poster'],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: ColorConstant.LIGHT_VIOLET,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25))),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "SUMMARY",
                                        style: StyleConstant.headerTextStyle,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Sub fee",
                                                style: StyleConstant
                                                    .priceTextStyle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Quantity",
                                                style: StyleConstant
                                                    .priceTextStyle,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
//                                            decoration: BoxDecoration(
//                                                border: Border(
//                                                    top: BorderSide(width: 1, color: ColorConstant.WHITE))),
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    top: 10,
                                                    bottom: 10),
                                              ),
                                              Text(
                                                "Total fee",
                                                style: StyleConstant
                                                    .priceTextStyle,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "  :     45000 VND",
                                                style: StyleConstant
                                                    .priceTextStyle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "  :     " +
                                                    seats.length.toString(),
                                                style: StyleConstant
                                                    .priceTextStyle,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: ColorConstant
                                                                .WHITE,
                                                            width: 1))),
                                                margin: EdgeInsets.only(
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                              ),
                                              Text(
                                                "  :     " +
                                                    (seats.length * 45000)
                                                        .toString() +
                                                    " VND",
                                                style: StyleConstant
                                                    .priceTextStyle,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ButtonGradientLarge("Buy ticket",
                                              () => {postOrderTicket(context)})
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            "FILM",
            "Book ticket")
        : Loading(
      type: "USER", title: "Booking ticket",
    );
  }
}

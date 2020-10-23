import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/modal.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Seat.dart';
import 'package:bymyeyefe/screens/Booking/OrderTicket.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import '../../Loading.dart';

class SeatMap extends StatefulWidget {
  final int filmId;
  final String dateTime;
  final String filmName;

  const SeatMap({Key key, this.filmId, this.dateTime, this.filmName})
      : super(key: key);

  @override
  _SeatMapState createState() =>
      _SeatMapState(this.filmId, this.dateTime, this.filmName);
}

class _SeatMapState extends State<SeatMap> {
  int filmId;
  String dateTime;
  String filmName;
  _SeatMapState(this.filmId, this.dateTime, this.filmName);

  List<String> data;
  int selected = 0;
  int timeSelected = 0;
  List<String> seatSelected = [];

  int row = 8;
  int col = 8;
  List<String> seatRow = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

  var seats;

  void createData(list) {
    seats = List.generate(row, (i) => List(col), growable: false);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        String id = seatRow[i] + j.toString();
        int status = 0;
        try {
          status = list[i][j];
        } on Exception catch (_) {
          throw Exception("Error on server");
        }
        seats[i][j] = Seat(id, status);
      }
    }
    print(seats);
  }

  List<Widget> _getSeats() {
    final List<Widget> seatItems = <Widget>[];
    for (int i = 0; i <= col; i++) {
      for (int j = 0; j <= col; j++) {
        if (i == 0 && j == 0) {
          seatItems.add(Container(
            width: seatHeight,
            height: 15,
            margin: EdgeInsets.all(1),
          ));
        } else if (i == 0 && j > 0) {
          seatItems.add(Container(
              width: seatHeight,
              height: 15,
              margin: EdgeInsets.all(1),
              child: Text(
                (j).toString(),
                style: StyleConstant.normalTextStyle,
                textAlign: TextAlign.center,
              )));
          if (j == 4) {
            seatItems.add(SizedBox(
              height: seatHeight,
              width: 0,
            ));
          }
        } else if (j == 0 && i > 0) {
          seatItems.add(Container(
              width: 15,
              height: seatHeight,
              margin: EdgeInsets.all(1),
              child: Text(
                seatRow[i - 1],
                style: StyleConstant.normalTextStyle,
                textAlign: TextAlign.center,
              )));
        } else {
          int status = (seats[i - 1][j - 1]).status;

          seatItems.add(Container(
              width: seatHeight,
              height: seatHeight,
              margin: EdgeInsets.all(1),
              decoration: status == 0
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: ColorConstant.LIGHT_VIOLET, width: 3))
                  : status == 1
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: ColorConstant.WHITE)
                      : BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: ColorConstant.RAINBOW_BUTTON,
                        ),
              child: FlatButton(
                onPressed: () => {
                  setState(() {
                    if (seats[i - 1][j - 1].status == 0) {
                      seats[i - 1][j - 1].status = 2;
                      seatSelected.add(seatRow[i-1] + (j).toString());
                    }else{
                      if (seats[i - 1][j - 1].status == 2) {
                        seats[i - 1][j - 1].status = 0;
                        seatSelected.remove(seatRow[i-1] + (j).toString());
                      }
                    }
                  })
                },
              )));
          if (j == 4) {
            seatItems.add(SizedBox(
              height: seatHeight,
              width: 0,
            ));
          }
        }
      }
    }
    return seatItems;
  }

  @override
  void initState() {
    print(filmId.toString() + filmName + dateTime);
    print("film id" + filmId.toString());
    if(ConstantVar.jwt != ""){
      fetchListSeat().then((value) => setState(() {}));

    }
  }

  Future<bool> fetchListSeat() async {
    //String time = dateTime.substring(5);
    print(UrlConstant.HOST +
        "/api/seats/showTime?filmId=$filmId&dateTime=$dateTime");
    final response = await http.get(
        UrlConstant.HOST +
            "/api/seats/showTime?filmId=$filmId&dateTime=$dateTime",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + ConstantVar.jwt,
        });
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      setState(() {
        int i = 0;
        int j = 0;
        var list = json.decode(response.body);
        createData(list);
        print(seats);
      });
      return true;
    } else {
      // If the server did not return a 200 K response,
      // then throw an exception.
      if(response.statusCode == 403){
        ConstantVar.jwt = "";
        ConstantVar.userDetail = null;
      }
      Modal.showSimpleCustomDialog(context, "Not found","");
      return false;
    }
  }

  double seatHeight = 20;

  @override
  Widget build(BuildContext context) {
    return  ConstantVar.jwt != "" ? ( seats != null ?
    MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          filmName,
                          style: StyleConstant.headerTextStyle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(dateTime, style: StyleConstant.formTextStyle),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: seatHeight * 17 ,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 5.0),
                          child: new GridView.count(
                              crossAxisCount: 10,
                              childAspectRatio: 1.0,
                              padding: const EdgeInsets.all(4.0),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              physics: NeverScrollableScrollPhysics(),
                              children: _getSeats())),
//
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child:

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          seatSelected.length != 0
                              ?Text("Seat No: " + seatSelected.join(", "),
                            style: StyleConstant.normalTextStyle,
                            overflow: TextOverflow.ellipsis,): Container(),
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonGradientLarge(
                              "Booking",
                              () => {
                                    if (seatSelected.length != 0)
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderTicket(
                                                      filmId: filmId,
                                                      filmName: filmName,
                                                      showTime: dateTime,
                                                      seats: seatSelected,
                                                    )))
                                      }
                                    else
                                      {Modal.showSimpleCustomDialog(context, "Please choose seat!", null)
//                                        showDialog(
//                                            context: context,
//                                            builder: (BuildContext context){
//                                              return AlertDialog(
//                                                content: Text("Please choose your seat!"),
//                                                 actions: <Widget>[
//                                                   FlatButton(
//                                                     child: Text("OK"),
//                                                     onPressed: (){Navigator.pop(context);},
//                                                   )
//                                                 ],
//                                              );
//                                            }
//                                        )
                                      }
                                  }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                )
              ],
            ),
          ),
        ),
        "USER",
        "Choose Seat") : Loading(type: "USER", title: "Choose seat")) : LoginScreen(handel: "");
  }
}

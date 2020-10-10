import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/modal.dart';
import 'package:bymyeyefe/model/Booking.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:bymyeyefe/screens/User/Avatar.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/DetailScreen.dart';
import 'package:bymyeyefe/screens/User/HistoryItem.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class History extends StatefulWidget {
  @override
  _History createState() => _History();
}

class _History extends State<History> {
  List<Booking> data = null;

  @override
  void initState() {
      fetchUserHistory(ConstantVar.jwt).then((value) => setState((){

      }));
  }

   Future<bool> fetchUserHistory(String jwt) async {
    if (jwt != "" && jwt != null) {
      final response = await http.get(UrlConstant.HISTORY, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $jwt',
      });
      print(json.decode(response.body));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON
        setState(() {
          data = new List<Booking>();
          json.decode(response.body).forEach((json) {
            if(json['seat'] == null && json['status'] == 0){
                return;
            }
              data.add(Booking.fromJson(json));

          });
        });
        return true;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Modal.showSimpleCustomDialog(context, "Not found", "");
        if(response.statusCode == 403){
          ConstantVar.jwt = "";
          ConstantVar.userDetail = null;
        }
        return false;
      }
    }else{
      ConstantVar.isLogin = false;
      ConstantVar.userDetail = null;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ?  MainLayOut.getMailLayout(
                context,
                Container(
                    color: ColorConstant.VIOLET,
                    padding:
                        EdgeInsets.symmetric( vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 50.0, left: 20, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(data.length, (index) => HistoryItem(booking: data[index]))
                                 .toList(),
                            ),
                          ),
                        ),
                      ],
                    )),
                "USER", "History")
        : Loading(type: "USER",title: "History");
  }
}

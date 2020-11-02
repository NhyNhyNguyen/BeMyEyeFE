import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/Homepage/NowshowingScreen.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/ResetPass.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../modal.dart';
import '../ButtonGradientLarge.dart';

class ChooseTypeUser extends StatefulWidget {
  final String handel;

  const ChooseTypeUser({Key key, this.handel}) : super(key: key);

  @override
  _ChooseTypeUserScreenState createState() =>
      _ChooseTypeUserScreenState(this.handel);
}

class _ChooseTypeUserScreenState extends State<ChooseTypeUser> {
  final String handle;

  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();

  _ChooseTypeUserScreenState(this.handle);

  void onPressedLoginFail(BuildContext context) {
    Modal.showSimpleCustomDialog(context, "Invalid user name pass word!", null);
  }

  Widget _assistanceBtn() {
    return ButtonGradientLarge(StringConstant.BECOME_ASSISTANCE, () {
      //to do
    });
  }

  Widget _volunteerBtn() {
    return ButtonGradientLarge(StringConstant.BECOME_VOLUNTEER, () {
      //to do
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 13,
                ),
                Image.asset(ImageConstant.LOGO),
                Text(
                  StringConstant.SLOGAN,
                  style: StyleConstant.bigTxtStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "100000\nBlind",
                        style: StyleConstant.normalTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.LIGHT_VIOLET,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstant.LIGHT_VIOLET),
                        child: Text(
                          "100000\nVolunteers",
                          style: StyleConstant.normalTextStyle,
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
        "SETTING",
        StringConstant.APP_NAME);
  }
}

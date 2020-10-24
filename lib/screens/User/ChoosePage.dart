import 'dart:convert';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/DetailScreen.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:bymyeyefe/services/dynamic_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class ChoosePageScreen extends StatefulWidget {
  @override
  _ChoosePageScreen createState() => _ChoosePageScreen();
}

class _ChoosePageScreen extends State<ChoosePageScreen> {

  Widget _signInBtn() {
    return ButtonGradientLarge(
        StringConstant.SIGN_IN,
        () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen(handel: "")))
            });
  }

  Widget _signUpBtn() {
    return ButtonGradientLarge(
        StringConstant.SIGN_UP,
        () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen(jwt: "",)))
            });
  }

  @override
  void initState(){
    UserDetail.fetchUserDetail(ConstantVar.jwt).then((value) => setState((){
    }));
  }

  @override
  Widget build(BuildContext context) {
    DynamicLinkService().handleDynamicLinks();
    return ConstantVar.jwt == "" ?MainLayOut.getMailLayout(
        context,
         Container(
            color: ColorConstant.VIOLET,
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageConstant.LOGO1, height: 270),
                Text(
                  "NOT LOGIN",
                  textScaleFactor: 1.5,
                  style: StyleConstant.normalTextStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                _signInBtn(),
                _signUpBtn(),
              ],
            )
         ),
        "USER", "Choose Page"): ChooseProfile();
  }
}

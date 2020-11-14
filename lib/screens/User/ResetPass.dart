import 'dart:convert';
import 'dart:ui';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/ResetPassword.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../modal.dart';
import '../ButtonGradientLarge.dart';
import 'DetailScreen.dart';
import 'SignUpScreen.dart';

class ResetPassScreen extends StatefulWidget {
  @override
  _ResetPassScreenState createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  Future<String> resetPass() async {

    var url = UrlConstant.HOST + '/api/reset-password' + '?email=' + emailController.text;
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("sign_up success");
      Modal.showSimpleCustomDialog(
          context, "Please enter mail to reset pass", "");
    } else {
      Modal.showSimpleCustomDialog(
          context, "Reset pass fail!", null);
    }
  }

  void onPressedResetPassSuccess(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetPassScreen()));
  }

  void onPressedResetPassFail(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetPassScreen()));
  }

//  }

  Widget _resetPassBtn() {
    return ButtonGradientLarge(StringConstant.RESET_PASS, () {
      if (_formKey.currentState.validate()) {
          resetPass();
      }
     ;
    });
  }

  @override
  void initState() {
    if (ConstantVar.userDetail != null) {
      emailController.text = ConstantVar.userDetail.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  MainLayOut.getMailLayout(
            context,
            Container(
              color: ColorConstant.VIOLET,
              // margin: EdgeInsets.only(bottom:  MediaQuery.of(context).size.height*0.1),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(left: 25, right: 20.0, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(ImageConstant.LOGO, height: 200, width: 240,fit: BoxFit.fitWidth, ),
                    Text("Reset your password",
                        style: StyleConstant.headerTextStyle),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 25.0),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFieldWidget.buildTextField(
                                  StringConstant.EMAIL,
                                  StringConstant.EMAIL_HINT,
                                  Icon(Icons.mail, color: Colors.white),
                                  TextInputType.emailAddress,
                                  emailController),
                              SizedBox(
                                height: 15,
                              ),
                              _resetPassBtn(),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    )
                  ],
                ),
              ),
            ),
            "USER", "Reset password");
  }
}

import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/modal.dart';
import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:bymyeyefe/services/text_to_speed_service.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../ButtonGradientLarge.dart';

class SignUpScreen extends StatefulWidget {
  final String type;

  const SignUpScreen({Key key, this.type}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState(this.type);
}

class _SignUpScreenState extends State<SignUpScreen> {
  String type;
  bool isSignUp = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  _SignUpScreenState(this.type);

  Future<http.Response> postUserDetail(
      BuildContext context, CubeUser user) async {
    final http.Response response = await http.post(
      UrlConstant.REGISTER,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": usernameController.text,
        "password": passwordController.text,
        "role": type == null || type == "" ? StringConstant.BLIND : type,
        "email": emailController.text,
        "id": user.id.toString()
      }),
    );
    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body));
      if (user == null) {
        Modal.showSimpleCustomDialog(context, "Sign up fail", null);
        print("sign up error");
        setState(() {
          isSignUp = false;
        });
        return null;
      }
      Modal.showSimpleCustomDialog(context, "Sign up successfull", "LOGIN");
      print("sign up success");
    } else {
      Modal.showSimpleCustomDialog(context, "Sign up fail", null);
      print("sign up error");
    }
    return response;
  }

  void _processSignUpError() {
    Modal.showSimpleCustomDialog(context, "Sign up fail", null);
  }

  Widget _signUpBtn(BuildContext context) {
    return ButtonGradientLarge(StringConstant.REGISTER_NOW, () {
      if (_formKey.currentState.validate()) {
        setState(() {
          isSignUp = true;
        });
        if (CubeSessionManager.instance.isActiveSessionValid()) {
          _signUpCC(context);
        } else {
          createSession().then((cubeSession) {
            _signUpCC(context);
          }).catchError(_processSignUpError);
        }
      }
    });
  }

  void _signUpCC(BuildContext context) {
    CubeUser user = CubeUser(
        login: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
        phone: "",
        customData: "{token: ''}");

    signUp(user).then((cubeUser) {
      print("sign up cc success");
      postUserDetail(context, cubeUser);
    }).catchError((error) {
      setState(() {
        isSignUp = false;
      });
      Modal.showSimpleCustomDialog(context, "Sign up to cc fail", null);
    });
  }

  @override
  void initState() {
    TextToSpeedService.speak("Chuyển sang trang đăng ký");

    usernameController.text = "zen";
    passwordController.text = "123456789";
    emailController.text = "zen@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    return !isSignUp
        ? MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Create your account",
                    style: StyleConstant.headerTextStyle),
                SizedBox(
                  height: 13,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: ColorConstant.LIGHT_VIOLET,
                      borderRadius: BorderRadius.circular(5),
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
                            Icon(Icons.email, color: Colors.white),
                            TextInputType.text,
                            emailController),
                        TextFieldWidget.buildTextField(
                            StringConstant.USERNAME,
                            StringConstant.USERNAME_HINT,
                            Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            TextInputType.text,
                            usernameController),
                        TextFieldWidget.buildPassField(
                            StringConstant.PASSWORD,
                            StringConstant.PASSWORD_HINT,
                            Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            TextInputType.visiblePassword,
                            passwordController),
                        Container(
                          child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Blind",
                                  style: StyleConstant.bigTxtStyle,
                                ),
                                Radio(
                                  value: StringConstant.BLIND,
                                  groupValue: type,
                                  activeColor: Color(0xFFcb4a9c),
                                  onChanged:
                                      (String value) {
                                    setState(() {
                                      type = StringConstant.BLIND;
                                    });
                                  },
                                ),
                                Text(
                                  "Volunteer",
                                  style: StyleConstant.bigTxtStyle,
                                ),
                                Radio(
                                  value: StringConstant.VOLUNTEER,
                                  groupValue: type,
                                  activeColor:Color(0xFFcb4a9c),
                                  onChanged: (String value) {
                                    setState(() {
                                      type = StringConstant.VOLUNTEER;
                                    });
                                  },
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
                _signUpBtn(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                )
              ],
            ),
          ),
        ),
        "USER",
        "Sign up")
        : Loading(type: "USER", title: "Sign up");
  }
}

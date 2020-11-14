import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/ResetPass.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:bymyeyefe/screens/call_video/select_opponents_screen.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bymyeyefe/screens/call_video/utils/configs.dart' as utils;

import '../../main.dart';
import '../../modal.dart';
import '../ButtonGradientLarge.dart';
import 'DetailScreen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  final String handel;
  final String type;

  const LoginScreen({Key key, this.handel, this.type}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState(this.handel, this.type);
}

class _LoginScreenState extends State<LoginScreen> {
  final String handle;
  final String type;
  final users = utils.users;
  bool _isLoginContinues = false;
  String token;

  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  _LoginScreenState(this.handle, this.type);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState(){
    // update token
    _firebaseMessaging.getToken().then((String token) {
      this.token = token;
      print(token);
    });
  }

  Widget _forgetPassAndRememberMe(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[_buildForgotPassBtn(context)],
    );
  }

  Widget _buildForgotPassBtn(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        padding: EdgeInsets.only(right: 0.0),
        onPressed: () => {
          print('reset pass'),
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPassScreen()))
        },
        child: Text(
          StringConstant.FORGOT_PASS,
          style: TextStyle(
              color: ColorConstant.BLUE_TEXT,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _loginBtn(BuildContext context) {
    return ButtonGradientLarge(StringConstant.SIGN_IN, () {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isLoginContinues = true;
        });
        login(context, usernameController.text, passController.text);
      }
    });
  }

Future<void > login (
     BuildContext context, String email, String password)  async {
    http.Response response = await http.post(
      UrlConstant.LOGIN,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );


    if (response.statusCode == 200) {
      User user =  User.fromJson(json.decode(response.body));
      if(user == null){
        Modal.showSimpleCustomDialog(context, "Login Fail!", "LOGIN");
        return null;
      }
      ConstantVar.user = user;
      _loginToCC(context, CubeUser(
          id: user.id, password: passController.text , login: user.username)
      );
      return user;
    } else {
      Modal.showSimpleCustomDialog(context, "Login Fail!", "LOGIN");
      return null;
    }
  }

  void onPressedLoginSuccess(BuildContext context) {
      Modal.showSimpleCustomDialog(context, "Login successfull!", "HOME_PAGE");
  }

  Widget _signInBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignUpScreen(type: type)))
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: StringConstant.HAVE_ACCOUNT,
              style: StyleConstant.smallTextStyle),
          TextSpan(
              text: StringConstant.REGISTER_NOW,
              style: TextStyle(
                  color: ColorConstant.BLUE_TEXT,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))
        ]),
      ),
    );
  }

  _loginToCC(BuildContext context, CubeUser user) {

    if (CubeSessionManager.instance.isActiveSessionValid()) {
      _loginToCubeChat(context, user);
    } else {
      createSession(user).then((cubeSession) {
        _loginToCubeChat(context, user);
      }).catchError(_processLoginError);
    }
  }

  void _loginToCubeChat(BuildContext context, CubeUser user) {
    CubeChatConnection.instance.login(user).then((cubeUser) {
      setState(() {
        _isLoginContinues = false;
      });
      _goSelectOpponentsScreen(context, cubeUser);
      ConstantVar.currentUser = cubeUser;
    }).catchError(_processLoginError);
  }

  void _processLoginError(exception) {

    setState(() {
      _isLoginContinues = false;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text("Something went wrong during login to ConnectyCube"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  void _goSelectOpponentsScreen(BuildContext context, CubeUser cubeUser) {

    if(ConstantVar.user != null && ConstantVar.user.firebaseToken != this.token){
      //update token
      ConstantVar.user.firebaseToken = this.token;
      User.updateUserProfile(ConstantVar.user);
      print("[[[[");
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = "a@gmail.com";
    passController.text = "123456789";
    return !_isLoginContinues
        ? MainLayOut.getMailLayout(
            context,
            Container(
                    color: ColorConstant.VIOLET,
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Sign in your account",
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
                                        Icon(Icons.mail, color: Colors.white),
                                        TextInputType.text,
                                        usernameController),
                                    TextFieldWidget.buildPassField(
                                        StringConstant.PASSWORD,
                                        StringConstant.PASSWORD_HINT,
                                        Icon(Icons.lock, color: Colors.white),
                                        TextInputType.text,
                                        passController),
                                    _forgetPassAndRememberMe(context),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    _loginBtn(context),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          _signInBtn(),
                        ],
                      ),
                    ),
                  ), "USER", "Login")
        : Loading(type: "USER",title: "Login");
  }
}

import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/call_video/call_screen.dart';
import 'package:bymyeyefe/screens/call_video/utils/call_manager.dart';
import 'package:bymyeyefe/screens/call_video/utils/configs.dart' as utils;
import 'package:bymyeyefe/screens/room/Room.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constant/ColorConstant.dart';
import '../ButtonGradientLarge.dart';

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Homepage();
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String url;
  bool _isLoginContinues = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _initConferenceConfig();
    if(CubeChatConnection.instance.systemMessagesManager == null){
      _loginToCC(ConstantVar.currentUser);
      _isLoginContinues = true;
    }else{
      _initCalls();
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        receiveCall(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        receiveCall(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        receiveCall(message);
      },
    );
  }

  void receiveCall(message) {
    json.decode(message);
    if (message['data'].roomId) {
      ConversationCallScreen(ConstantVar.currentCall, message['data'].roomId,
          message['data'].roomId, false);
    }
  }

  _loginToCC(CubeUser user) {
    if (CubeSessionManager.instance.isActiveSessionValid()) {
      _loginToCubeChat(user);
    } else {
      createSession(user).then((cubeSession) {
        _loginToCubeChat(user);
      }).catchError(_processLoginError);
    }
  }

  void _loginToCubeChat(CubeUser user) {
    CubeChatConnection.instance.login(user).then((cubeUser) {
      setState(() {
        _isLoginContinues = false;
      });
      ConstantVar.currentUser = cubeUser;
      _initCalls();
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
            content: Text("Something went wrong during reconnect to ConnectyCube"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }


  void _initConferenceConfig() {
    ConferenceConfig.instance.url = utils.SERVER_ENDPOINT;
  }

  void _initCalls() {
    if(CubeChatConnection.instance.systemMessagesManager == null){
      _loginToCC(ConstantVar.currentUser);
      _isLoginContinues = true;
    }else{
      ConstantVar.callClient = ConferenceClient.instance;
      ConstantVar.callManager = CallManager.instance;
      ConstantVar.callManager.onReceiveNewCall = (roomId, participantIds, name) {
        _showIncomingCallScreen(roomId, participantIds, name);
      };

      ConstantVar.callManager.onCloseCall = () {
        ConstantVar.currentCall = null;
      };
    }
  }

  void _showIncomingCallScreen(String roomId, List<int> participantIds, name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncomingCallScreen(roomId, participantIds, name),
      ),
    );
  }

  Widget _howToCallBtn() {
    return ConstantVar.user.role != StringConstant.BLIND
        ? ButtonGradientLarge(StringConstant.HOW_TO_CALL, () {
            //to do
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ListRoom()));
          })
        : Expanded(
            child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10, bottom: 5),
            padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: ColorConstant.RAINBOW_BUTTON,
            ),
            child: FlatButton(
              child: Text(StringConstant.SPECIAL_CALL,
                  style: StyleConstant.btnLargeStyle),
              onPressed: () => {_startCall()},
            ),
          ));
  }

  void _startCall() async {
    if (ConstantVar.currentUser != null) {
      ConstantVar.currentCall = await ConstantVar.callClient
          .createCallSession(ConstantVar.currentUser.id);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationCallScreen(ConstantVar.currentCall,
              ConstantVar.currentUser.id.toString(), [], false),
        ),
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstantVar.currentUser != null && ConstantVar.user != null
        ? !_isLoginContinues ?  MainLayOut.getMailLayout(
            context,
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration:
                  BoxDecoration(color: ColorConstant.VIOLET, boxShadow: [
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    child: Column(
                      children: [
//                    Image.asset(ImageConstant.LOGO),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(ImageConstant.NO_IMAGE),
                                      fit: BoxFit.cover,
                                    ),
                                    // border: Border.all(color: Colors.white70, width: 4),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                onPressed: () => {},
                              ),
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          ConstantVar.user.email,
                          style: StyleConstant.bigTxtStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Member since 7/11/2020",
                          style: StyleConstant.colorTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "111111",
                                    style: StyleConstant.normalTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Blind",
                                    style: StyleConstant.colorTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 45,
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "11111",
                                    style: StyleConstant.normalTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Volunteers",
                                    style: StyleConstant.colorTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  ConstantVar.user.role != StringConstant.BLIND
                      ? Container(
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
                          child: Text(
                            "You will receive notification when someone need you help",
                            style: StyleConstant.normalTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                  ConstantVar.user.role == StringConstant.VOLUNTEER
                      ? Expanded(flex: 1, child: Container())
                      : Container(),
                  _howToCallBtn(),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
            "USER",
            StringConstant.APP_NAME) : Loading(title: StringConstant.APP_NAME, type: "USER",)
        : LoginScreen();
  }
}

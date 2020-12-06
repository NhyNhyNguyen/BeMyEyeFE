import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/screens/Menu/Menu.dart';
import 'package:bymyeyefe/screens/User/DetailScreen.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:bymyeyefe/screens/room/ListRoom.dart';
import 'package:bymyeyefe/screens/tutorial/ChooseTypeUser.dart';
import 'package:bymyeyefe/voice_control/SpeechToText.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MainLayOut {
  static bool _hasSpeech = false;
  static double level = 0.0;
  static double minSoundLevel = 50000;
  static double maxSoundLevel = -50000;
  static String lastWords = "";
  static String lastError = "";
  static String lastStatus = "";
  static final SpeechToText speech = SpeechToText();

  static Widget getMailLayout(BuildContext context, Widget widget, String type,
      String title) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
    new GlobalKey<ScaffoldState>();
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.grey,
          focusColor: Colors.blueAccent,
          hoverColor: Colors.yellow,
          fontFamily: "Open Sans"),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery
              .of(context)
              .size
              .height * 0.07),
          child: AppBar(
              elevation: 0,
              backgroundColor: ColorConstant.LIGHT_VIOLET,
              title: Text(
                title,
                style: StyleConstant.appBarText,
              ),
              actions: <Widget>[
                type == 'HOME'
                    ? IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Homepage()));
                  },
                )
                    : Container(),
              ],
              leading: new IconButton(
                  icon: new Icon(Icons.storage, color: ColorConstant.WHITE),
                  onPressed: () => _scaffoldKey.currentState.openDrawer())),
        ),
        drawer: Menu(),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
            ),
            widget,
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.09,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.06,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                color: ColorConstant.LIGHT_VIOLET,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(35),
                                    topLeft: Radius.circular(35))
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()));
                                  },
                                  child: type == 'HOME'
                                      ? Image.asset(ImageConstant.HOME_YELLOW,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.04)
                                      : Image.asset(ImageConstant.HOME_GRAY,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.04),
                                ),
                                Container(),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen()));
                                    },
                                    child: type == 'USER'
                                        ? Icon(
                                      Icons.person,
                                      color: Colors.yellow,
                                      size: 38,
                                    )
                                        : Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 38,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015,
                            color: ColorConstant.LIGHT_VIOLET,
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.09,
                        alignment: Alignment.center,
                        child: ConstantVar.user == null ||
                            ConstantVar.currentUser == null ||
                            ConstantVar.user.role == StringConstant.BLIND ? MyApp() :
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: .26,
                                  spreadRadius: level * 1.5,
                                  color: Colors.white.withOpacity(.05))
                            ],
                            color: ColorConstant.WHITE,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListRoom()));
                              },
                              child: type == 'ROOM'
                                  ? Icon(
                                Icons.phone_in_talk,
                                color: Colors.yellow,
                                size: 38,
                              )
                                  : Icon(
                                Icons.phone_in_talk,
                                color: ColorConstant.LIGHT_VIOLET,
                                size: 38,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
//        floatingActionButton:
//          MyApp(),
      ),
    );
  }
}

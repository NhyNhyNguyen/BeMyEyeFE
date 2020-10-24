import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/screens/Homepage/Homepage.dart';
import 'package:bymyeyefe/screens/Homepage/NowshowingScreen.dart';
import 'package:bymyeyefe/screens/Homepage/Search.dart';
import 'package:bymyeyefe/screens/Menu/Menu.dart';
import 'package:bymyeyefe/screens/Menu/MenuItem.dart';
import 'package:bymyeyefe/screens/News/News.dart';
import 'package:bymyeyefe/screens/News/TicketPrice.dart';
import 'package:bymyeyefe/screens/Showtime/Showtime.dart';
import 'package:bymyeyefe/screens/Showtime/ShowtimeScreen.dart';
import 'package:bymyeyefe/screens/User/ChoosePage.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
import 'package:flutter/material.dart';

class MainLayOut {
  void loginHandle(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen(handel: "LOGIN")));
  }

  static Widget getMailLayout(
      BuildContext context, Widget widget, String type, String title) {
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
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
              elevation: 0,
              backgroundColor: ColorConstant.LIGHT_VIOLET,
              title: Text(
                title,
                style: StyleConstant.appBarText,
              ),
              actions: <Widget>[
                type == 'HOME' ? IconButton(
                  icon: Icon(Icons.search, color: Colors.white), onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                },) : Container(),
              ]
              ,
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
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            alignment: Alignment.bottomCenter,
                            color: ColorConstant.LIGHT_VIOLET,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                              /*  InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NowshowingScreen()));
                                  },
                                  child: type == 'HOME'
                                      ? Image.asset(ImageConstant.HOME_YELLOW,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05)
                                      : Image.asset(ImageConstant.HOME_GRAY,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowtimeScreen()));
                                  },
                                  child: type == 'CAL'
                                      ? Image.asset(
                                          ImageConstant.CALENDAR_YELLOW,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06)
                                      : Image.asset(ImageConstant.CALENDAR_GRAY,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsScreen()));
                                  },
                                  child: type == 'FILM'
                                      ? Image.asset(ImageConstant.FILM_YELLOW,
                                          height: 45)
                                      : Image.asset(ImageConstant.FILM_GRAY,
                                          height: 45),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen(handel: "LOGIN",)));
                                  },
                                  child: type == 'USER'
                                      ? Image.asset(ImageConstant.PERSON_YELLOW,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06)
                                      : Image.asset(ImageConstant.PERSON_GRAY,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06),
                                )*/
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.015,
                            color: ColorConstant.LIGHT_VIOLET,
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(ImageConstant.TICKET,
                              height: MediaQuery.of(context).size.height * 0.12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/detect_object/home.dart';
import 'package:bymyeyefe/screens/User/ChangePassword.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/DetailScreen.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
import 'package:flutter/material.dart';

import 'MenuItem.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Container(
      color: ColorConstant.LIGHT_VIOLET,
      child: ListView(
        children: <Widget>[
          /*   new UserAccountsDrawerHeader(
                accountName: new Text('Raja'),
                accountEmail: new Text('testemail@test.com'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage(UrlConstant.IMAGE + "iu2.jpg"),
                ),
              ),*/
          Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.BG),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.LOGO1),
                      fit: BoxFit.cover,
                    ),
                    // border: Border.all(color: Colors.white70, width: 4),
                  ),
                ),
              ],
            ),
          ]),
          ConstantVar.user == null
              ? Container()
              : Text(
                  ConstantVar.user.email,
                  textAlign: TextAlign.center,
                  style: StyleConstant.btnSelectedStyle,
                ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
          ConstantVar.user == null
              ? Column(
                  children: <Widget>[
                    MenuItem(
                      text: StringConstant.DETECT,
                      icon: Icons.search,
                      selectHandle: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()))
                      },
                    ),
                    MenuItem(
                      text: StringConstant.SIGN_UP,
                      icon: Icons.person_add,
                      selectHandle: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen(
                                      type: "",
                                    )))
                      },
                    ),
                    MenuItem(
                      text: StringConstant.LOGIN,
                      icon: Icons.lock_open,
                      selectHandle: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      type: "",
                                    )))
                      },
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: ColorConstant.WHITE))),
                        child: Row(
                          children: <Widget>[
                            Switch(
                              value: ConstantVar.currentLocal == "vi-VN"
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  ConstantVar.currentLocal =
                                      value ? "vi-VN" : "en-US";
                                });
                              },
                              activeTrackColor: ColorConstant.VIOLET,
                              activeColor: ColorConstant.WHITE,
                            ),
                            Text(
                              ConstantVar.currentLocal == "vi-VN"
                                  ? "Viet Nam"
                                  : "English",
                              style: StyleConstant.priceTextStyle,
                            ),
                          ],
                        )),
                  ],
                )
              : Column(
                  children: <Widget>[
                    MenuItem(
                      text: StringConstant.DETECT,
                      icon: Icons.search,
                      selectHandle: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()))
                      },
                    ),
//                    MenuItem(
//                      text: StringConstant.PROFILE,
//                      icon: Icons.person,
//                      selectHandle: () => {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => ChooseProfile()))
//                      },
//                    ),
//                    MenuItem(
//                      text: StringConstant.EDIT,
//                      icon: Icons.edit,
//                      selectHandle: () => {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => DetailScreen()))
//                      },
//                    ),
                    MenuItem(
                      text: StringConstant.CHANGE_PASS,
                      icon: Icons.lock_open,
                      selectHandle: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen()))
                      },
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: ColorConstant.WHITE))),
                        child: Row(
                          children: <Widget>[
                            Switch(
                              value: ConstantVar.currentLocal == "vi-VN"
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  ConstantVar.currentLocal =
                                      value ? "vi-VN" : "en-US";
                                });
                              },
                              activeTrackColor: ColorConstant.VIOLET,
                              activeColor: ColorConstant.WHITE,
                            ),
                            Text(
                              ConstantVar.currentLocal == "vi-VN"
                                  ? "Viet Nam"
                                  : "English",
                              style: StyleConstant.priceTextStyle,
                            ),
                          ],
                        )),
                    MenuItem(
                      text: StringConstant.LOGOUT,
                      icon: Icons.arrow_forward,
                      selectHandle: () => {
                        ConstantVar.user = null,
                        ConstantVar.currentCall = null,
                        ConstantVar.removeData('user'),
                        ConstantVar.removeData('cubeUser'),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(handel: "")))
                      },
                    ),
                  ],
                ),
        ],
      ),
    ));
  }
}

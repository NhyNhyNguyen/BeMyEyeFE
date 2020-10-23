import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:bymyeyefe/screens/Homepage/BannerImage.dart';
import 'package:bymyeyefe/screens/Homepage/CategoryMovie.dart';
import 'package:bymyeyefe/screens/News/News.dart';
import 'package:bymyeyefe/screens/User/ResetPassword.dart';
import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
import 'package:bymyeyefe/services/dynamic_link_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import '../../constant/ColorConstant.dart';
import 'package:bymyeyefe/screens/Homepage/Homepage.dart';
import '../ButtonGradient.dart';
import 'CommingsoonScreen.dart';
import 'OptionTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NowshowingScreen extends StatefulWidget {
  @override
  _NowshowingScreen createState() => _NowshowingScreen();
}

class _NowshowingScreen extends State<NowshowingScreen> {
  String type = "now-showing";

//  String url;
//  List<Movie> data;

  void choseOption(type) {
    setState(() {
      this.type = type;
    });
  }

  Future handleDynamicLinks() async {
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // handle link that has been retrieved
    _handleDeepLink(data);

    // Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      print(deepLink.queryParameters);
      String token = deepLink.queryParameters.values.toList()[0];
      print(token + " token");
      if (deepLink.path.contains('register')) {
        print(token + " token");
        ConstantVar.registerToken = token;
      } else {
        print(token + " reset token");

        ConstantVar.resetPassWordToken = token;
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    handleDynamicLinks();
    print(ConstantVar.registerToken + " token");
    String url = UrlConstant.URL_FILM + 'now-showing';
    {
      http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
      }).then((http.Response response) {
        setState(() {
          data = new List<Movie>();
          json.decode(response.body).forEach((json) {
            data.add(Movie.fromJson(json));
          });
        });
      });
      print('222');
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
//    url  = UrlConstant.URL_FILM + 'now-showing';
//    if (data == null) {
//      http.get(url).then((http.Response response) {
//        setState((){
//          data = new List<Movie>();
//          json.decode(response.body).forEach((json) {
//            data.add(Movie.fromJson(json));
//          });
//        });
//      });
//    };

    return ConstantVar.registerToken == ""
        ? (ConstantVar.resetPassWordToken == ""
            ? ((type == 'now-showing')
                ? MainLayOut.getMailLayout(
                    context,
                    Container(
                      color: ColorConstant.VIOLET,
                      child: Column(
                        children: <Widget>[
                          Container(
                            //height: 500,
                            height: MediaQuery.of(context).size.height * 0.77,
                            child: ListView(
                              children: <Widget>[
                                BannerImage(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10.0),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      ButtonGradient(
                                          type,
                                          "now-showing",
                                          StringConstant.NOW_SHOWING,
                                          () => choseOption("now-showing")),
                                      ButtonGradient(
                                          type,
                                          "coming-soon",
                                          StringConstant.COMMING_SOON,
                                          () => choseOption("coming-soon")),
                                    ],
                                  ),
                                ),
                                //OptionTab('now-showing'),
                                Container(
                                    // height: 435,
                                    height: MediaQuery.of(context).size.height *
                                        0.675,
                                    child: CategoryMovie(type)),

//                      Container(
//                         // height: 435,
//                          height: MediaQuery.of(context).size.height * 0.675,
//                          child: MyHomepage()),
                                //MyHomepage(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    "HOME",
                    "Home")
                : CommingsoonScreen())
            : ResetPasswordScreen(
                jwt: ConstantVar.resetPassWordToken,
              ))
        : SignUpScreen(
            jwt: ConstantVar.registerToken,
          );
  }
}

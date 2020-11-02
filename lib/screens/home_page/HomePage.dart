import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/screens/Bloc/homepage_bloc.dart';
import 'package:bymyeyefe/screens/Bloc/homepage_event.dart';
import 'package:bymyeyefe/screens/Bloc/homepage_state.dart';
import 'package:bymyeyefe/screens/ButtonGradient.dart';
import 'package:bymyeyefe/screens/Homepage/CategoryMovie.dart';
import 'package:flutter/material.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:bymyeyefe/screens/Homepage/BannerImage.dart';
import 'package:flutter/widgets.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import '../../constant/ColorConstant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import 'dart:convert';

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

class _HomepageState extends State<Homepage>  {
  String url;
  List<Movie> data;

  @override
  Widget build(BuildContext context) {
    return MainLayOut.getMailLayout(context, Container(
      color: ColorConstant.VIOLET,
    ), "USER", StringConstant.APP_NAME);
  }
}



import 'package:bymyeyefe/detect_face/face_detect.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(brightness: Brightness.light),
    home: Homepage(),
    title: "Face Recognition",
    debugShowCheckedModeBanner: false,
  ));
}

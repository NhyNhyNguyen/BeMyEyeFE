import 'package:bymyeyefe/screens/video/CameraHomeScreen.dart';
import 'package:bymyeyefe/screens/video/HomeScreen.dart';
import 'package:bymyeyefe/screens/video/SplashScreen.dart';
import 'package:camera/camera.dart';
import 'dart:async';

import 'package:flutter/material.dart';

import 'constant/Constant.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    //logError(e.code, e.description);
  }

  runApp(
    MaterialApp(
      title: "Video Recorder App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        HOME_SCREEN: (BuildContext context) => HomeScreen(),
        CAMERA_SCREEN: (BuildContext context) => CameraHomeScreen(cameras),
      },
    ),
  );
}

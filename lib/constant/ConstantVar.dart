import 'dart:convert';

import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/call_video/utils/call_manager.dart';
import 'package:camera/camera.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:localstorage/localstorage.dart';

class ConstantVar {

  static String jwt = "";
  static bool isLogin = false;
  static UserDetail userDetail = null;
  static User user = null;
  static String registerToken = "";
  static String resetPassWordToken = "";
  static String currentLocal = "vi-VN";
  static CubeUser currentUser;
  static CallManager callManager;
  static ConferenceClient callClient;
  static ConferenceSession currentCall;
  static List<CameraDescription> cameras;
  static FlutterTts flutterTts;
  static String findObject = "";
  static final double volume = 0.5;
  static final double pitch = 1.6;
  static final double rate = 0.8;
  static int volunteerSize = 0;
  static int blindSize = 0;
  static double timeFindObject = 0;

  static final LocalStorage storage = new LocalStorage('localstorage_app');


  static void saveData(cubeUser) {
    storage.setItem('cubeUser', jsonEncode(cubeUser));
  }

  static Future<void> getData() async {
    String data = await storage.getItem('cubeUser');
    if(data != null && data.isNotEmpty){
      ConstantVar.currentUser = CubeUser.fromJson(json.decode(data));
    }
  }

  static void saveUserData(user) {
    storage.setItem('user', jsonEncode(user));
  }

  static Future<void> getUserData() async {
    String data = await storage.getItem('user');
    if(data != null && data.isNotEmpty){
      ConstantVar.user = User.fromJson2(json.decode(data));
    }
  }

  static void removeData(String key){
    storage.deleteItem(key);
  }
}


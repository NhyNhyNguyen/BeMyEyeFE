
import 'dart:io';

import 'package:flutter/foundation.dart';

class UrlConstant{
  //
 // static const String HOST = "http://192.168.43.171:9000";
  static const String HOST = "https://myangeleyes.herokuapp.com";
  static const String REGISTER = HOST + "/register";
  static const String LOGIN = HOST + "/login";
  static const String LOGOUT = HOST + "/logout";
  static const String GET_USERS_BY_ROLE = HOST + "/getAllUserByRole";
  static const String PROFILE =  HOST + "/api/profile";
  static const String EDIT = HOST + "/api/edit-profile";
  static const String RESET_PASS = HOST + "/api/reset-password";
  static const String IMAGE = HOST + "/api/images/";
  static const String POST_IMAGE = HOST + "/api/users/upload-avatar";
  static const String HISTORY = HOST + "/api/reservations/history";


  static const String URL_COGNITIVE = HOST +"/v1/cognitive_face" ;


}
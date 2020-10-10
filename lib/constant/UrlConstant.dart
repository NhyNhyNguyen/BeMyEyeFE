
import 'dart:io';

import 'package:flutter/foundation.dart';

class UrlConstant{
  //
 // static const String HOST = "http://192.168.43.171:9000";
  static const String HOST = "https://moviesworldbe.herokuapp.com";
  static const String REGISTER = HOST + "/api/register";
  static const String LOGIN = HOST + "/api/auth";
  static const String PROFILE =  HOST + "/api/profile";
  static const String EDIT = HOST + "/api/edit-profile";
  static const String RESET_PASS = HOST + "/api/reset-password";
  static const String IMAGE = HOST + "/api/images/";
  static const String POST_IMAGE = HOST + "/api/users/upload-avatar";
  static const String HISTORY = HOST + "/api/reservations/history";
  static const String SHOW_TIME_FILM = HOST + "/api/showtimefilms/dateTime";
  static const String GET_LIST_SEAT = HOST + "/api/seats/showTime";
  static const String POST_BOOK = HOST + "/api/reservations";
  static const String PUT_CANCEL = HOST + "/api/reservations/cancel/";
  static const String CONFIRM_ACCOUNT = HOST + "/api/confirm-account";


 // static const String HOST_MOBILE= "http://192.168.43.171:9000/";
  //https://moviesworldbe.herokuapp.com/apihttps://moviesworldbe.herokuapp.com/api
 static const String HOST_MOBILE= "https://moviesworldbe.herokuapp.com/";
  static const String URL_FILM = HOST_MOBILE + "api/films/";
  static const String URL_IMAGE = HOST_MOBILE + "api/images/";
  static const String URL_COMMENT = HOST_MOBILE+ "api/comments/film/";
  static const String URL_GET_RATE = HOST_MOBILE + "api/films/get-rate?";
  static const String URL_PUT_RATE = HOST_MOBILE + "api/films/";   // /2/rate
  static const String URL_POST_COMMENT = HOST_MOBILE +"api/comments";
  static const String URL_GET_SHOWTIME = HOST_MOBILE + "api/showtimefilms/filmInDate?date=" ;
  static const String URL_SEARCH = HOST_MOBILE +"api/films/searching?name=" ;
}
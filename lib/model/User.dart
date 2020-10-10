import 'dart:convert';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;


class User {
  final String email;
  final String password;

  User({this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['username'],
      password: json['phone'],
    );
  }

  static Future<User> login(String username, String password) async {
    http.Response response = await http.post(
      UrlConstant.LOGIN,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      ConstantVar.jwt = json.decode(response.body)["token"];
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}

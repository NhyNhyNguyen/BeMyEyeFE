import 'dart:convert';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String email;
  final String password;
  final String username;
  final String role;

  User({this.id, this.email, this.password, this.role, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    var userJson = json['user'];
    if (userJson == null) return null;
    return User(
      id: int.parse(userJson['id']),
      email: userJson['email'],
      password: userJson['password'],
      role: userJson['role'],
      username: userJson['username'],
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

  static Future<List> getUsersByRole(String role) async {
    http.Response response = await http.get(
      UrlConstant.GET_USERS_BY_ROLE + "?role=${role}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      print("========");
      return List.from(json.decode(response.body));
    } else {
      return [];
    }
  }
}

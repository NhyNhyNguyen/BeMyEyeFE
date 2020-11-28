import 'dart:convert';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  String email;
  String password;
  String username;
  final String role;
  String firebaseToken;
  String avatarUrl;
  int createTime;
  int numHelp;
  int point;

  User(
      {this.id,
      this.email,
      this.password,
      this.role,
      this.username,
      this.firebaseToken,
      this.avatarUrl,
      this.createTime,
      this.numHelp,
      this.point});

  factory User.fromJson(Map<String, dynamic> json) {
    var userJson = json['user'];
    if (userJson == null) return null;
    return User(
      id: (userJson['id']),
      email: userJson['email'],
      password: userJson['password'],
      role: userJson['role'],
      username: userJson['username'],
      firebaseToken: userJson['token'],
      avatarUrl: userJson['avatarUrl'],
      createTime: userJson['createTime'],
      numHelp: userJson['numHelp'],
      point: userJson['point'],
    );
  }

  factory User.fromJson2(Map<String, dynamic> userJson) {
    return User(
      id: (userJson['id']),
      email: userJson['email'],
      password: userJson['password'],
      role: userJson['role'],
      username: userJson['username'],
      firebaseToken: userJson['token'],
      avatarUrl: userJson['avatarUrl'],
      createTime: userJson['createTime'],
      numHelp: userJson['numHelp'],
      point: userJson['point'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'id': this.id,
      'password': this.password,
      'role': this.role,
      'token': this.firebaseToken,
      'email': this.email,
      'avatarUrl': this.avatarUrl,
      'createTime': this.createTime,
      'numHelp': this.numHelp,
      'point': this.point,
    };
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
      UrlConstant.GET_USERS_BY_ROLE + "?role=${role}&roomID=1111}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body) as List;
    } else {
      return [];
    }
  }

  static Future<bool> updateUserProfile(User user) async {
    http.Response response = await http.post(
      UrlConstant.UPDATE_PROFILE,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': user.id.toString(),
        'username': user.username,
        'email': user.email,
        'token': user.firebaseToken,
        'avatarUrl': user.avatarUrl
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      User user = User.fromJson(json.decode(response.body));
      if (user == null) {
        return false;
      }
      ConstantVar.user = user;
      ConstantVar.saveUserData(user);
      ConstantVar.saveData(ConstantVar.currentUser);
      return true;
    } else {
      return true;
    }
  }

  static Future<dynamic> getSizeUser() async {
    http.Response response = await http.get(
      UrlConstant.GET_USER_SIZE,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return "";
    }
  }
}

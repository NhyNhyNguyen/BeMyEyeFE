import 'dart:convert' ;
import 'dart:convert';
import 'dart:io';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;

class UserDetail {
  int id;
  String username;
  String fullName;
  String password;
  String email;
  String address;
  String phone;
  String avt;

  UserDetail(
      {
      this.id,
      this.username,
      this.password,
      this.fullName,
      this.address,
      this.phone,
      this.email,
      this.avt});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      avt: json['avatar'],
    );
  }

  static Future<bool> fetchUserDetail(String jwt) async {
    if (jwt != "" || jwt != null) {
      final response = await http.get(UrlConstant.PROFILE, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $jwt',
      });
      print(json.decode(response.body));

      if (response.statusCode == 200) {
        ConstantVar.isLogin = true;
        ConstantVar.userDetail =
            UserDetail.fromJson(json.decode(response.body));
        return true;
      } else {
        ConstantVar.isLogin = false;
        ConstantVar.userDetail = null;
        return false;
      }
    }else{
      ConstantVar.isLogin = false;
      ConstantVar.userDetail = null;
    }
    return false;
  }
}

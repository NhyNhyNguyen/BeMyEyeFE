import 'dart:convert';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;

class Room {
  final int id;
  final int member;
  final String name;
  final String avatarUrl;

  Room({this.member, this.id, this.name, this.avatarUrl});

  factory Room.fromJson1(Map<String, dynamic> json) {
    var roomJson = json['room'];
    if (roomJson == null) return null;
    return Room(
      id: roomJson['id'],
      member: roomJson['member'],
      name: roomJson['name'],
      avatarUrl: roomJson['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'menber': this.member,
      'name': this.name,
      'avatarUrl': this.avatarUrl
    };
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: (json['id']),
      name: json['name'],
      member: json['member'],
      avatarUrl: json['avatarUrl'],
    );
  }


  static Future<Room> create() async {
    http.Response response = await http.post(
      UrlConstant.CREATE_ROOM,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': ConstantVar.user.id.toString(),
        'name': ConstantVar.user.username.toString(),
        "avatarUrl" : ConstantVar.user.avatarUrl
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return null;
    } else {
      return null;
    }
  }

  static Future<bool> removeRoom() async {
    http.Response response = await http.get(
      UrlConstant.REMOVE_ROOM + "?room=${ConstantVar.user.id}}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["err"] == 0 ? true : false;
    } else {
      return false;
    }
  }

  static Future<bool> joinRoom(int roomId) async {
    http.Response response = await http.post(
      UrlConstant.JOIN_ROOM,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': roomId.toString(),
        'userJoinId': ConstantVar.user.id.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)["err"] == 0 ? true : false;
    } else {
      return false;
    }
  }


  static Future<List<Room>> getListEmptyRoom() async {
    http.Response response = await http.get(
      UrlConstant.GET_EMPTY_ROOM,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body)["err"] == 0) {
        return List<Room>.from((json.decode(response.body)['room']).map((model)=> Room.fromJson(model)).toList());
      }
      return [];
    } else {
      return [];
    }
  }
}

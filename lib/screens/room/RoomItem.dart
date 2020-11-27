import 'dart:convert';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/model/Room.dart';
import 'package:bymyeyefe/screens/call_video/call_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatefulWidget {
  final Room room;

  const RoomItem({Key key, this.room}) : super(key: key);

  @override
  _RoomItemState createState() => _RoomItemState(room);
}

class _RoomItemState extends State<RoomItem> {
  final Room room;

  _RoomItemState(this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
          color: ColorConstant.LIGHT_VIOLET,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 15), blurRadius: 15),
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -10), blurRadius: 10)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(room.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5))),
                Text(
                  room != null ? room.name : "",
                  style: StyleConstant.normalTextStyle,
                )
              ],
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.only(left: 0, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: ColorConstant.RAINBOW_BUTTON,
            ),
            child: FlatButton(
              child: Text(StringConstant.JOIN_CALL,
                  style: StyleConstant.btnSelectedStyle),
              onPressed: () => {
              joinCall(room.id, room.name)
            },
            ),
          )
        ],
      ),
    );
  }

  void joinCall(roomId, roomName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncomingCallScreen(roomId.toString(), [roomId], roomName),
      ),
    );
  }

}

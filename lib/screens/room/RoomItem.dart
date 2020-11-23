import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/model/Room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatefulWidget {
  final List<Room> users;

  const RoomItem({Key key, this.users}) : super(key: key);

  @override
  _RoomItemState createState() => _RoomItemState(users);
}

class _RoomItemState extends State<RoomItem> {
  final List<Room> users;

  _RoomItemState(this.users);

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
          Row(
            children: users.map((room) {
              return Container(
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
              );
            }).toList(),
          ),
          Container(
            height: 70,
            width: 70,
            padding: EdgeInsets.only(left: 0, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: ColorConstant.RAINBOW_BUTTON,
            ),
            child: IconButton(
              icon: Icon(
                Icons.phone,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }
}

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/room/RoomItem.dart';
import 'package:flutter/cupertino.dart';

class ListRoom extends StatefulWidget {
  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  @override
  Widget build(BuildContext context) {
    return ConstantVar.currentUser != null && ConstantVar.user != null
        ? MainLayOut.getMailLayout(
            context,
            Container(
                width: double.infinity,
                height: double.infinity,
                color: ColorConstant.VIOLET,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20.0),
                  child: Column(
                    children: [
                      RoomItem(users: [ConstantVar.user], ),
                      RoomItem(users: [ConstantVar.user,]),
                      RoomItem(users: [ConstantVar.user],),
                      RoomItem(users: [ConstantVar.user],),
                      RoomItem(users: [ConstantVar.user],),
                    ],
                  ),
                )),
            "USER",
            "Rooms")
        : LoginScreen();
  }
}

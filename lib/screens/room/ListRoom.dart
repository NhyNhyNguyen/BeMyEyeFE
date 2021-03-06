import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/Room.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/room/RoomItem.dart';
import 'package:flutter/cupertino.dart';

class ListRoom extends StatefulWidget {
  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  List<Room> rooms;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Room.getListEmptyRoom().then((rooms) => {
          setState(() {
            this.isLoading = false;
          }),
          this.rooms = rooms
        });
  }

  @override
  Widget build(BuildContext context) {
    return ConstantVar.currentUser != null && ConstantVar.user != null
        ? !isLoading
            ? MainLayOut.getMailLayout(
                context,
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: ColorConstant.VIOLET,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: 10, bottom: 60.0, left: 10, right: 10),
                      child: Column(
                        children: rooms.map((room) {
                          return RoomItem(
                            room: room,
                          );
                        }).toList(),
                      ),
                    )),
                "ROOM",
                "Rooms")
            : Loading(
                type: "ROOM",
                title: "Rooms",
              )
        : LoginScreen();
  }
}

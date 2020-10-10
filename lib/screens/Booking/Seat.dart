import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/screens/Booking/SeatStatus.dart';
import 'package:flutter/material.dart';

class SeatScreen extends StatefulWidget {
  final SeatStatus status;

  SeatScreen({this.status});

  @override
  _SeatState createState() => _SeatState(status: this.status);
}

class _SeatState extends State<SeatScreen> {
  final SeatStatus status;
   double seatHeight = 40;

  _SeatState({this.status});

  @override
  Widget build(BuildContext context) {
    seatHeight = MediaQuery.of(context).size.width*0.08;
    return status == SeatStatus.AVAILABLE
        ? Container(
            width: seatHeight,
            height: seatHeight,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorConstant.LIGHT_VIOLET, width: 3)
            ),
            child: FlatButton(
              onPressed: () => {},
            ))
        : (status == SeatStatus.SELECTED
            ? Container(
                margin: EdgeInsets.all(4),
                width: seatHeight,
                height: seatHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: ColorConstant.RAINBOW_BUTTON,
                ),
                child: FlatButton(
                  onPressed: () => {},
                ))
            : Container(
                margin: EdgeInsets.all(4),
                width: seatHeight,
                height: seatHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorConstant.WHITE),
                child: FlatButton(
                  onPressed: () => {},
                )));
  }
}

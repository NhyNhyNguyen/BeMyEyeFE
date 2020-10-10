import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  final String time;
  final String hour;
  final bool selected;

  Time({this.time, this.hour, this.selected});

  @override
  _TimeState createState() =>
      _TimeState(time: time, hour: hour, selected: selected);
}

class _TimeState extends State<Time> {
  final String time;
  final String hour;
  final bool selected;

  _TimeState({this.time, this.hour, this.selected});

  @override
  Widget build(BuildContext context) {
    return selected
        ? Container(
        width: MediaQuery.of(context).size.width * 0.21,
        height: MediaQuery.of(context).size.width * 0.21,
        margin: EdgeInsets.only(left: 3,right: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: ColorConstant.RAINBOW_BUTTON,
            ),
            child: FlatButton(
              onPressed: () => {},
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      time.toString(),
                      style: StyleConstant.btnSelectedStyle,
                    ),
                    Text(
                      hour,
                      style: StyleConstant.normalTextStyle,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ))
        : Container(
            width: MediaQuery.of(context).size.width * 0.21,
            height: MediaQuery.of(context).size.width * 0.21,
            margin: EdgeInsets.only(left: 3,right: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: ColorConstant.VIOLET
            ),
            child: FlatButton(
              onPressed: () => {},
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      time.toString(),
                      style: StyleConstant.btnSelectedStyle,
                    ),
                    Text(
                      hour,
                      style: StyleConstant.normalTextStyle,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ));
  }
}

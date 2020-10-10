import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/material.dart';

class Date extends StatefulWidget {
  final String date;
  final int day;
  final bool selected;
  final Function handle;

  Date({this.date, this.day, this.selected, this.handle});

  @override
  _DateState createState() =>
      _DateState(date: date, day: day, selected: selected);
}

class _DateState extends State<Date> {
  final String date;
  final int day;
  final bool selected;
  final Function handle;

  _DateState({this.date, this.day, this.selected, this.handle});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 83,
        decoration: selected
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22)),
                gradient: ColorConstant.RAINBOW_BUTTON,
              )
            : BoxDecoration(),
        child: FlatButton(
          onPressed: handle,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  day.toString(),
                  style: StyleConstant.formTextStyle,
                ),
                Text(
                  date,
                  style: StyleConstant.moreSmallTextStyle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ));
  }
}

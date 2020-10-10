import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/material.dart';

class ButtonGradient extends StatelessWidget {
  final String type;
  final String typeoption;
  final String text;
  final Function selectHandler;

  ButtonGradient(this.type, this.typeoption, this.text, this.selectHandler);
  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: ColorConstant.RAINBOW_BUTTON,
      ),
      child: FlatButton(
        child: type == typeoption
            ? Text(text, style: TextStyle(fontSize: 18, color: ColorConstant.WHITE, fontWeight: FontWeight.w600))
            : Text(text, style: TextStyle(fontSize: 18, color: ColorConstant.VIOLET, fontWeight: FontWeight.w600) ),
        onPressed: selectHandler,
      ),
    );
  }
}

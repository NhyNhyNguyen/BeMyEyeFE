
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/material.dart';

class ButtonGradientSmall extends StatelessWidget {
  final String text;
  final Function selectHandler;

  ButtonGradientSmall( this.text, this.selectHandler);
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 60,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: ColorConstant.RAINBOW_BUTTON,
        ),
        child: FlatButton(
          child: Text(text, style:StyleConstant.btnSelectedStyle),
          onPressed: selectHandler,
        ),
      );
  }
}

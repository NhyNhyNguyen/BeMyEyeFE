
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/material.dart';

class ButtonGradientLarge extends StatelessWidget {
  final String text;
  final Function selectHandler;

  ButtonGradientLarge( this.text, this.selectHandler);
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.only(left: 5, right: 5, top: 15,  bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: ColorConstant.RAINBOW_BUTTON,
        ),
        child: FlatButton(
          child: Text(text, style:StyleConstant.btnSelectedStyle ),
          onPressed: selectHandler,
        ),
      );
  }
}

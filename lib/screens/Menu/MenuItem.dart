import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function selectHandle;

  const MenuItem({Key key, this.text, this.icon, this.selectHandle}) : super(key: key);
  @override
  _MenuItemState createState() => _MenuItemState(this.text, this.icon, this.selectHandle);
}

class _MenuItemState extends State<MenuItem> {
  final String text;
  final IconData icon;
  final Function selectHandle;

  _MenuItemState(this.text, this.icon, this.selectHandle);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: ColorConstant.WHITE))),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: ColorConstant.WHITE,
            ),
            FlatButton(
              child: Text(text, style: StyleConstant.priceTextStyle),
              onPressed: selectHandle,
            ),
          ],
        ));
  }
}

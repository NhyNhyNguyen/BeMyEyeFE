import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

import 'constant/ColorConstant.dart';
import 'layout/mainLayout.dart';

class Loading extends StatelessWidget {
  final String title;
  final String type;

  const Loading({Key key, this.title, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayOut.getMailLayout(context,
        Stack(
          children: <Widget>[
            Container(
              color: ColorConstant.VIOLET,
              width: double.infinity,
              height: double.infinity,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                      width: 50, height: 50,
                      child:  CircularProgressIndicator(
                        strokeWidth: 4,
                        backgroundColor: Colors.white,
                        valueColor: new AlwaysStoppedAnimation<Color>(ColorConstant.LIGHT_VIOLET),
                      )
                  ),
                  Text(
                    "Please wait!",
                    style: StyleConstant.normalTextStyle,
                  )
                ],
              ),
            )

          ],
        )
        , type, title);
  }
}
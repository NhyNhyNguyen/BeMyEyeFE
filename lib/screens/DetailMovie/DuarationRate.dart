import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:flutter/material.dart';

class DurationRate extends StatelessWidget {
  final int timeLimit;

  const DurationRate(this.timeLimit);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    timeLimit.toString() + " mins" ,
                    style: TextStyle(
                      color: ColorConstant.YELLOW,
                      fontSize: 18,
                    ),),
                  Text("Duration", style: TextStyle(
                    fontSize: 20,
                    color: ColorConstant.GRAY_TEXT,
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(ImageConstant.RATE_ICON, fit: BoxFit.cover, height: 30,),
                      Image.asset(ImageConstant.RATE_ICON, fit: BoxFit.cover, height: 30,),
                      Image.asset(ImageConstant.RATE_ICON, fit: BoxFit.cover, height: 30,),
                      Image.asset(ImageConstant.RATE_ICON, fit: BoxFit.cover, height: 30,),
                      Image.asset(ImageConstant.RATE_ICON, fit: BoxFit.cover, height: 30,),
                    ],
                  ),),
                  Text("Rate", style: TextStyle(
                    fontSize: 20,
                    color: ColorConstant.GRAY_TEXT,
                  ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//import 'package:bymyeyefe/screens/ButtonGradient.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:bymyeyefe/constant/StringConstant.dart';
//import '../../constant/StringConstant.dart';
//import 'CommingsoonScreen.dart';
//import 'NowshowingScreen.dart';
//
//
//class OptionTab extends StatelessWidget  {
//  final String type;
//  OptionTab(this.type);
//
//
//
//  @override
//  Widget build(BuildContext context) {
//
//    void choseOption(type){
//      if(type == "now-showing"){
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => NowshowingScreen()),
//        );
//      };
//      if(type == "coming-soon"){
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => CommingsoonScreen()),
//        );
//      };
//    }
//
//    return Container(
//      //padding: EdgeInsets.symmetric(vertical: 10),
//      padding: EdgeInsets.only(bottom: 8),
//      width: double.infinity,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          ButtonGradient(type, "now-showing", StringConstant.NOW_SHOWING, () => choseOption("now-showing")),
//          ButtonGradient(type, "coming-soon", StringConstant.COMMING_SOON, () => choseOption("coming-soon")),
//        ],
//      ),
//    );
//  }
//
//
//}

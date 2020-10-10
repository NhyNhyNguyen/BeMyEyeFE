import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieContent extends StatelessWidget {
  final String content;

  MovieContent(this.content);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Synopsis", style: StyleConstant.bigTxtStyle,),
          Text(content, style: TextStyle(fontSize: 14, color: ColorConstant.GRAY_TEXT, height: 2),)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'ColorConstant.dart';

class StyleConstant {
  static const TextStyle normalTextStyle = TextStyle(
      color: ColorConstant.WHITE,
      fontSize: 20,
      fontWeight: FontWeight.normal);
  static const TextStyle formTextStyle = TextStyle(
      color: Colors.white70,
      fontSize: 18,
      fontWeight: FontWeight.w600);

  static const TextStyle hintTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle colorTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle boldHintTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );


  static const TextStyle smallTextStyle = TextStyle(
      color: ColorConstant.WHITE,
      fontSize: 12,
      fontWeight: FontWeight.normal);

  static const TextStyle moreSmallTextStyle = TextStyle(
      color: ColorConstant.WHITE,
      fontSize: 14,
      fontWeight: FontWeight.normal);

  static const TextStyle largerHeaderTextStyle = TextStyle(
      color: ColorConstant.WHITE,
      fontSize: 30,
      fontWeight: FontWeight.bold
  );
  static const TextStyle headerTextStyle = TextStyle(
      color: ColorConstant.WHITE,
      fontSize: 25,
      fontWeight: FontWeight.bold
  );

  static const TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold
  );

  static const TextStyle btnSelectedStyle = TextStyle(
    color: ColorConstant.WHITE,
      fontFamily: "Open Sans",
      fontWeight: FontWeight.bold,
      fontSize: 18
  );

  static const TextStyle btnNormalStyle = TextStyle(
    color: ColorConstant.BLACK,
      fontFamily: "Open Sans",
      fontWeight: FontWeight.bold,
      fontSize: 16
  );

  static const btnLargeStyle = TextStyle(
    color: ColorConstant.WHITE,
    fontWeight: FontWeight.w600,
    fontSize: 25,
  );

  static const priceTextStyle = TextStyle(
    color: ColorConstant.WHITE,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const appBarText = TextStyle(
    color: ColorConstant.WHITE,
    fontSize: 20,
  );

  // style for detail page
  static const bigTxtStyle = TextStyle(
    fontSize: 19,
    color: ColorConstant.WHITE,
  );

  static const mediumTxtStyle = TextStyle(
    fontSize: 16,
    color: ColorConstant.WHITE,
    fontWeight: FontWeight.w500,
  );

  static const smallTxtStyle = TextStyle(
    fontSize: 14,
    color: ColorConstant.GRAY_TEXT,
  );

  static const smallTxtStyleWhite = TextStyle(
    fontSize: 14,
    color: ColorConstant.WHITE,
  );

  static const txtStyleTime = TextStyle(
    fontSize: 12,
    color: ColorConstant.GRAY_TEXT,
  );

  static const TextStyle menuText = TextStyle(
      color: Colors.black,
      fontFamily: "Open Sans",
      fontSize: 25,
      fontWeight: FontWeight.bold
  );


  static const TextStyle menuSmallText = TextStyle(
      color: Colors.black,
      fontFamily: "Open Sans",
      fontSize: 20,
      fontWeight: FontWeight.bold
  );


  static const UnderlineInputBorder enabledBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1));
  static const focusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: ColorConstant.WHITE, width: 1.5),
  );



}

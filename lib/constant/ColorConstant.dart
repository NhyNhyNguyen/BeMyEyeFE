import 'package:flutter/material.dart';

class ColorConstant{
  static const Color RED = Color(0xFFCA3E3D);
  static const Color YELLOW = Color(0xFFE2E096);
  static const Color GREY = Color(0xFFC4C4C4);
  static const Color BLUE_ACCENT = Colors.blueAccent;
  static const Color WHITE = Colors.white;
  static const Color BLACK = Colors.black;
  static const Color GREEN = Colors.green;

  static const Color VIOLET = Color(0xFF1F203E);
  static const Color LIGHT_VIOLET = Color(0xFF2E3350);
  static const Color GRAY_TEXT = Color(0xFFACB3B9);
  static const Color BLUE_TEXT = Color (0xFF6133c3);
  static const LinearGradient GRD_BLACK = LinearGradient(
                                        colors: [
                                        Color.fromARGB(250, 50, 50, 50),
                                        Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      );

  static  LinearGradient RAINBOW_BUTTON =  LinearGradient(
                                              colors: [
                                                Color(0xFFfc5b47).withOpacity(1),
                                                Color(0xFFcb4a9c).withOpacity(0.8),
                                                Color(0xFFa039d0).withOpacity(0.6)
//                                                Color(0xFFf66f5e).withOpacity(0.8),
//                                                Color(0xFFb743bc).withOpacity(0.8),
//                                                Color(0xFF26238a).withOpacity(0.8)
                                              ],
                                              end: Alignment.centerRight,
                                              begin: Alignment.centerLeft,
                                            );

  static  LinearGradient RAINBOW_BUTTON_BOOK =  LinearGradient(
    colors: [
      Color(0xFFfc5b47).withOpacity(0.8),
      Color(0xFFcb4a9c).withOpacity(0.8),
      Color(0xFFa039de).withOpacity(0.8)
    ],
    end: Alignment.bottomCenter,
    begin: Alignment.topCenter,
  );

  static  LinearGradient RAINBOW_NAME =  LinearGradient(
    colors: [
      Color(0xFFfc5b47).withOpacity(0),
      Color(0xFFcb4a9c).withOpacity(0.5),
      Color(0xFFa039de).withOpacity(0.8)
    ],
    end: Alignment.bottomCenter,
    begin: Alignment.topCenter,
  );

}
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String email;

  const Avatar({this.imageUrl, this.username, this.email});

  @override
  Widget build(BuildContext context) {
    return Stack(
    children: <Widget>[
      Container(
        height: 120,
        decoration: BoxDecoration(
            color: ColorConstant.LIGHT_VIOLET,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
        ),
      ),
      Positioned(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                height: MediaQuery.of(context).size.height*0.3,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network( imageUrl, fit: BoxFit.cover, ),
                )
              ),
              Container(
                decoration: BoxDecoration(
                ),
                padding: EdgeInsets.only(bottom: 20,left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(username ,
                          style: StyleConstant.btnSelectedStyle,
                        ),
                        email != null ?Text(email,
                          style: StyleConstant.hintTextStyle,
                        ) : Container()
                      ],
                    ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      )
    ],
  );
  }
}

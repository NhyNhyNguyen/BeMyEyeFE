import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {

  final String avatarUser;
  final String fullNameUser;
  final String content;
  final String timeCreate;

  CommentItem(
      this.avatarUser,
      this.fullNameUser,
      this.content,
      this.timeCreate
      ) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, ),
      padding: EdgeInsets.all(0),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Image.network(UrlConstant.URL_IMAGE + avatarUser, fit: BoxFit.cover, height: 50, width: 50, ),
              )
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10,),
              height:  MediaQuery.of(context).size.height * 0.15,
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(fullNameUser, style: StyleConstant.mediumTxtStyle,),
                      Text(timeCreate.substring(0,10), style: StyleConstant.txtStyleTime, ),
                    ],
                  ),

                  Text(content, style: StyleConstant.smallTxtStyleWhite,)
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}

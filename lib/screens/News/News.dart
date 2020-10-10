
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';

import 'package:bymyeyefe/screens/News/TicketPrice.dart';

import '../../constant/ImageConstant.dart';
import '../../constant/StringConstant.dart';
import '../../constant/StringConstant.dart';
import '../User/ChoosePage.dart';
import 'NewsDetail.dart';
import 'OptionTab.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreen createState() => _NewsScreen();
}

class _NewsScreen extends State<NewsScreen>  {

  static const data = const
  [
    {'image':ImageConstant.NEWS1, 'detail': StringConstant.NEWSDETAIL1},
    {'image':ImageConstant.NEWS2, 'detail': StringConstant.NEWSDETAIL2},
    {'image':ImageConstant.NEWS3, 'detail': StringConstant.NEWSDETAIL3},
    {'image':ImageConstant.NEWS1, 'detail': StringConstant.NEWSDETAIL1},
  ];

//static const List<String> data = <String>[
//  ImageConstant.NEWS1,
//  ImageConstant.NEWS2,
//  ImageConstant.NEWS3,
//  ImageConstant.NEWS1
//];

 static List listImage() {
  return data.map((item) => ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Image.asset(item['image'], height: 180, fit: BoxFit.cover,))).toList();
}


  @override
  Widget build(BuildContext context) {
    List<Widget> myWidgets = listImage().asMap().entries.map((item) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          child: item.value,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(item.key, data)));
          },
        ),
      );
    }).toList();


    Widget _listImage(){
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
          child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 2,
              children: myWidgets,
          ),


      );
    }
    return MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          child: Column(
            children: <Widget>[
              //OptionTab('news'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _listImage(),
            ],
          ),
          ),
        "FILM", "News");
  }
}

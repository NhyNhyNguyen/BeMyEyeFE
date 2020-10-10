
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';

import 'package:bymyeyefe/screens/News/News.dart';

import '../../constant/ColorConstant.dart';
import '../../constant/StringConstant.dart';
import '../../constant/StyleConstant.dart';
import '../ButtonGradientLarge.dart';
import 'OptionTab.dart';
import '../ButtonGradient.dart';

class TicketPriceScreen extends StatefulWidget {
  @override
  _TicketPriceScreen createState() => _TicketPriceScreen();
}

class _TicketPriceScreen extends State<TicketPriceScreen>  {


  @override
  Widget build(BuildContext context) {

    void choseBtn(type){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => null),
        );
    }
    return MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          child: Column(
            children: <Widget>[
              OptionTab('ticketprice'),
              Image.asset(ImageConstant.TICKET_PRICE, height: 270),
              ButtonGradientLarge( StringConstant.BOOK_TICKET, () => choseBtn),
            ],
          ),

        )
        ,
        "FILM", "Ticket price");
  }
}

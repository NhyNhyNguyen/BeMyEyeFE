
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
import '../ButtonGradient.dart';
import 'TicketPrice.dart';


class OptionTab extends StatelessWidget  {
  final String type;
  OptionTab(this.type);

  @override
  Widget build(BuildContext context) {
    void choseOption(type){
      if(type == "ticketprice"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TicketPriceScreen()),
        );
      };
      if(type == "news"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsScreen()),
        );
      };
    }

      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonGradient(type, "ticketprice", StringConstant.TICKET_PRICE, () => choseOption("ticketprice")),
            ButtonGradient(type, "news", StringConstant.NEWS, () => choseOption("news")),

          ],
        ),
      );
    }


}

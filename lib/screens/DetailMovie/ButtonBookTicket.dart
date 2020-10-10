
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/screens/Booking/TicketBooking.dart';
import 'package:flutter/material.dart';

class ButtonBookTicket extends StatelessWidget {
  final String text;
  final int filmId;
  final String filmName;
  final String poster;

  ButtonBookTicket( this.text, this.filmId, this.filmName, this.poster);
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width * 0.33,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: ColorConstant.RAINBOW_BUTTON_BOOK,
        ),
        child: FlatButton(
          child: Column(
            children: <Widget>[
              Image.asset(ImageConstant.TICKET, fit: BoxFit.cover,height: 50,),
              Text(text, style:StyleConstant.mediumTxtStyle ),
            ],
          ),
          onPressed: ()=>{
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingTicket(filmId: filmId, name: filmName, poster: this.poster,)),
          )
          },
        ),
      );
  }
}

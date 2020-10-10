import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/screens/News/News.dart';
import 'package:flutter/material.dart';
import 'ButtonBookTicket.dart';
import 'Test.dart';


class Description extends StatelessWidget {
  final int filmId;
  final String filmName;
  final String premiere;
  final String timeLimit;
  final String cast;
  final String director;
  final String nation;
  final String poster;

  const Description(this.premiere, this.timeLimit,this.cast, this.director, this.nation, this.filmId, this.filmName, this.poster);

  @override
  Widget build(BuildContext context) {
    print(filmName + filmId.toString());
    void choseBtn(type){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => null),
      );
    }


    return Container(
      height: 150,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Premiere: ", style: StyleConstant.mediumTxtStyle,),
                    Text(premiere, style: StyleConstant.smallTxtStyle,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Duration: ", style: StyleConstant.mediumTxtStyle,),
                    Text(timeLimit+ " mins", style: StyleConstant.smallTxtStyle,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Cast: ", style: StyleConstant.mediumTxtStyle,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: Text(cast, style: StyleConstant.smallTxtStyle,overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Director: ", style: StyleConstant.mediumTxtStyle,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(director, style: StyleConstant.smallTxtStyle,overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: ButtonBookTicket(StringConstant.BOOK_TICKET, filmId, filmName, this.poster),
          )
        ],
      ),
    );
  }
}

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/screens/Booking/SeatMap.dart';
import 'package:bymyeyefe/screens/DetailMovie/DetailMovieScreen.dart';
import 'package:bymyeyefe/screens/DetailMovie/Test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';

class ShowtimeMovieItem extends StatelessWidget {
  String date;
  final int idFilm;
  final String name;
  final String imageUrl;
  final List genres;
  final String timeLimit;
  final List showtime;

  ShowtimeMovieItem(
      @required this.date,
      @required this.idFilm,
      @required this.name,
      @required this.imageUrl,
      @required this.genres,
      @required this.timeLimit,
      @required this.showtime
      ) ;



  @override
  Widget build(BuildContext context) {


    Widget TimeItem(String time){
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: ColorConstant.GRAY_TEXT,
          ),
        ),
        child: InkWell(
            onTap: (){
              date = date.replaceAll('/', '-');
              Navigator.push(context, MaterialPageRoute(builder: (context) => SeatMap(filmId: idFilm, dateTime: date + " " + time , filmName: name)));
              print(date + " " + time);
            },
            child: Text(time, style: StyleConstant.mediumTxtStyle,)),
      );
    }


    String listGenres="";
    for(var item in genres){
      listGenres = listGenres + ", " + item['name'];
    }
    listGenres = listGenres.substring(2);

    return InkWell(
      onTap: null,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.LIGHT_VIOLET,
          borderRadius: BorderRadius.all(Radius.circular(30)),),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Container(
                      height: 120,
                      width: 120,
                      child: Image.network(UrlConstant.URL_IMAGE+ imageUrl, fit: BoxFit.cover, )),),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style:TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.WHITE,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,),
                      Text(listGenres, style: StyleConstant.mediumTxtStyle,),
                      Text(timeLimit + ' mins', style: StyleConstant.mediumTxtStyle,),
                    ],
                  ),
                )
              ],
            ),
//            Container(
//              padding: EdgeInsets.only( top: 10),
//              child: Row(
//              children:
//              showtime.map(
//                  (item) => TimeItem(item)
//              ).toList()
//              ),
//            ),
            Container(
              height: 50,
              padding: EdgeInsets.only( top: 10),
              child: ListView.builder(
                itemCount: showtime.length,
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return TimeItem(showtime[index]);
                  }
              )
            ),
          ],
          )
        ),
    );
  }
}

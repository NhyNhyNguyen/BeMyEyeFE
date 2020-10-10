import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/screens/DetailMovie/DetailMovieScreen.dart';
import 'package:bymyeyefe/screens/DetailMovie/Test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';

class MovieItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final List genres;

  MovieItem(
      @required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.genres
      ) ;


  @override
  Widget build(BuildContext context) {
    String listGenres="";
    for(var item in genres){
      listGenres = listGenres + ", " + item['name'];
    }
    listGenres = listGenres.substring(2);

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMovieScreen(id)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                height: 180,
                width: double.infinity,
                child: Image.network(UrlConstant.URL_IMAGE+ imageUrl, fit: BoxFit.cover, )),),
            Text(
              name,
              style: TextStyle(
                              fontSize: 16,
                              color: ColorConstant.WHITE,
                            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,),
            Text(listGenres, style: TextStyle(fontSize: 12, color: ColorConstant.GRAY_TEXT),overflow: TextOverflow.ellipsis,
              maxLines: 1,)

          ],
        ),
      ),

    );
  }
}

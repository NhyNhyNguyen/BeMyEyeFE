import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:flutter/material.dart';

class Poster extends StatefulWidget {
  final String imageUrl;

  const Poster({Key key, this.imageUrl}) : super(key: key);

  @override
  _PosterState createState() => _PosterState(this.imageUrl);
}

class _PosterState extends State<Poster> {
  final String imageUrl;

  _PosterState(this.imageUrl);
  @override
  Widget build(BuildContext context) {
   return Container(
      margin: EdgeInsets.only(right: 15),
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius:BorderRadius.all(Radius.circular(15)),
        image:  DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,),
      ),
    );
     }
}

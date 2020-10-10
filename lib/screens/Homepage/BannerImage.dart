import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:flutter/material.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/model/Movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "dart:math";
import 'package:http/http.dart' as http;
import 'dart:convert';


List<String> listImageRandomed=[];
List<Movie> data;

List getRandomSubList(List list){
  listImageRandomed.clear();
  final _random = new Random();
  for( var i =0; i<= list.length /2  + 1; i++){

    var element = list[_random.nextInt(list.length)];
    print("chose" + element);
    listImageRandomed.add(element);
    list.remove(element);
  }
}

class BannerImage extends StatefulWidget {
  @override
  _BannerImageState createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  @override
  Widget build(BuildContext context) {
    String url = UrlConstant.URL_FILM + "now-showing";
    if (data == null) {
      http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
      }).then((http.Response response) {
        setState(() {
          data = new List<Movie>();
          json.decode(response.body).forEach((json) {
            data.add(Movie.fromJson(json));
          });
        });
      });
    };
    if (data == null) return Container(
      child: Icon(Icons.cached, color: ColorConstant.GRAY_TEXT, size: 50,),
    );

    List<dynamic> listImage = data.map(
          (item) => item.poster,
    ).toList();

    getRandomSubList(listImage);

    List<Widget> imageSliders = listImageRandomed.map((item) =>
        Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child:
              Image.network(UrlConstant.URL_IMAGE+ item, fit: BoxFit.cover, ),
            ),
          ),
        )).toList();

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: ColorConstant.LIGHT_VIOLET,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))
            ),
          ),
          Positioned(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.88,
              margin: EdgeInsets.only(left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.06),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),
          )
        ],
      ),
    );
  }

}
//class BannerImage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//  return Container(
//    child: Stack(
//      children: <Widget>[
//        Container(
//          height: 100,
//          decoration: BoxDecoration(
//              color: ColorConstant.LIGHT_VIOLET,
//              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30))
//          ),
//        ),
//        Positioned(
//          child: Container(
//            width: MediaQuery.of(context).size.width * 0.88,
//            margin:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
//            child: CarouselSlider(
//              options: CarouselOptions(
//                height: 200,
//                autoPlay: true,
//                viewportFraction: 1.0,
//                enlargeCenterPage: true,
//              ),
//         items: imageSliders,
//       ),
//          ),
//        )
//      ],
//    ),
//  );
//  }
//}

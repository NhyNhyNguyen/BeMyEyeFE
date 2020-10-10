import 'dart:convert';

import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/screens/DetailMovie/DetailMovieScreen.dart';
import 'package:bymyeyefe/screens/User/ChoosePage.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentInput extends StatefulWidget {
  String idMovie;
  CommentInput(this.idMovie);
  @override
  _CommentInputState createState() => _CommentInputState(idMovie);
}

class _CommentInputState extends State<CommentInput> {
  String idMovie;
  _CommentInputState(this.idMovie);

  final _keyInput = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();

  Future<http.Response> postComment() async {
    print("hello");
    final http.Response response = await http.post(
      UrlConstant.URL_POST_COMMENT,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization':
        'Bearer ' + ConstantVar.jwt,
      },
      body: jsonEncode(<String, String>{
        "content": inputController.text,
        "filmId": idMovie
      }),
    );
    print(idMovie);
    print(inputController.text + "hhhh");
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailMovieScreen(idMovie)));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginScreen(handel: "")));
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: ColorConstant.GRAY_TEXT)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, ),
      padding: EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height * 0.13,
      child: Row(
        children: <Widget>[
//          Container(
//            margin: EdgeInsets.only(left: 10),
//              child: ClipRRect(
//                borderRadius: BorderRadius.all(Radius.circular(30)),
//                child: Image.asset(ImageConstant.POSTER, fit: BoxFit.cover, height: 50, width: 50, ),
//              )
//          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              height:  MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: ColorConstant.GRAY_TEXT,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Form(
                key: _keyInput,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Leave your comment here...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                  ),
                  controller: inputController,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: ColorConstant.WHITE),
            onPressed: () => {
              (ConstantVar.jwt != "")
              ? postComment()
              : Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(handel: "")),
              ) },
          )
        ],
      ),
    );
  }
}

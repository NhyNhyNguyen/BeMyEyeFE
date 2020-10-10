
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final kUrl = "http://192.168.1.57:9000/api/film/now-showing";
  List<dynamic> data;
//  final kUrl = "http://192.168.1.57:9000/api/image/iu2.jpg";
//  dynamic data;


  @override
  Widget build(BuildContext context) {
    if (data == null) {
      http.get(this.kUrl).then((http.Response response) {
        setState(() => data = json.decode(response.body) );
      });
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("test"),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 1 : data.length,
          itemBuilder: (context, index) {
            if (data == null) return Text("null");
            return new ListTile(
              title: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(data[index]["name"], style: new TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),),
                  new Text(data[index]["filmDescription"]["premiere"], style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),

                  new Text(data[index]["genres"][0]["name"], style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
                  new Image.network("http://192.168.1.57:9000/api/image/" + data[index]["poster"], height: 50, ),
                ],
              ),
            );
          }
      ),
    );
  }
}



import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesAndFace extends StatelessWidget {
  final File imageFile;
  final List<Face> faces;

  const ImagesAndFace({this.imageFile, this.faces});

  @override
  Widget build(BuildContext context) {
    print(faces[0].boundingBox.top);
    print("______");

    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Image.file(this.imageFile, fit: BoxFit.cover),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView(children: faces.map<Widget>((f) {
            return FaceCoordinates(face: f);
          }).toList()),
        )
      ],
    );
  }
}

class FaceCoordinates extends StatelessWidget {
  const FaceCoordinates({this.face});

  final Face face;

  @override
  Widget build(BuildContext context) {
    print(face);
    print("===");
    final pos = face.boundingBox;
    return ListTile(
        title: Text('${pos.top}, ${pos.bottom}, ${pos.left},${pos.right}'));
  }
}

import 'dart:ui';

import 'package:bymyeyefe/detect_face/smile_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:ui' as ui show Image;


import 'ImagesAndFaces.dart';

class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  File _imageFile;
  List<Face> _faces;
  ui.Image image;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: _loading
            ? Text('Press The floating Action Button for load image!')
            : FittedBox(
          child: SizedBox(
            width: image.width.toDouble(),
            height: image.height.toDouble(),
            child: FacePaint(
              painter: SmilePainter(image, _faces),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _chooseImageAndDetectFaces(),
        tooltip: "Pick image",
        child: Icon(Icons.add_to_photos),
      ),
    );
  }

  Future<void> _chooseImageAndDetectFaces() async {
    final imageFile =  await ImagePicker.pickImage(source: ImageSource.gallery);
    final images = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector(
        FaceDetectorOptions(
            mode: FaceDetectorMode.accurate,
            enableLandmarks: true
        )
    );
    final faces = await faceDetector.processImage(images);
    image = await _loadImage(imageFile);
    if(mounted){
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
        _loading = false;
      });
    }

  }


  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

}

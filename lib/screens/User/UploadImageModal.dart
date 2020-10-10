import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageModal {
  static Future<File> file;
  static String status = '';
  static String base64Image;
  static File tmpFile;
  static String errMessage = 'Error Uploading Image';


  static Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            margin: EdgeInsets.only(right: 20),
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.file(
              snapshot.data,
              fit: BoxFit.cover,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Container(
            margin: EdgeInsets.only(right: 20),
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ConstantVar.userDetail.avt == null ? AssetImage(ImageConstant.LOGO): NetworkImage(
                    UrlConstant.IMAGE + ConstantVar.userDetail.avt),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
    );
  }

  static void showSimpleCustomDialog(BuildContext context, String imageUrl, Function startUpload, Function chooseImage) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "Upload avartar",
                    style: TextStyle(color: ColorConstant.BLACK, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )),
            showImage(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed:
                      chooseImage,

                    child: Text(
                      'Choose Image',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.white30,
                    onPressed:
                      startUpload,
                    child: Text(
                      'Upload',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }
}

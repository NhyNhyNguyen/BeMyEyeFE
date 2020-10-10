import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "Upload Image";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    print(tmpFile.path + fileName);
    _uploadFileAsFormData(tmpFile.path, fileName);
  }

  upload(String fileName) {
    http.post(UrlConstant.POST_IMAGE, body: {
      "file": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Future<void> _uploadFileAsFormData(String path, String fileName) async {
    try {
      final dio = Dio();

      dio.options.headers = {
        'Content-Type': 'multilpart/form-data',
        'Authorization': 'Bearer ${ConstantVar.jwt}',
      };

      final file = await MultipartFile.fromFile(path,
          filename: fileName, contentType: MediaType('image', 'png'));

      final formData = FormData.fromMap(
        {
          'file': file,
          'type': "image/png",
        },
      ); //

      final response = await dio.post(
        // or dio.post
        UrlConstant.POST_IMAGE,
        data: formData,
      );
    } catch (err) {
      print('uploading error: $err');
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            margin: EdgeInsets.only(right: 20),
            width: 200,
            height: 200,
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
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ConstantVar.userDetail.avt == null
                    ? AssetImage(ImageConstant.LOGO)
                    : NetworkImage(
                        UrlConstant.IMAGE + ConstantVar.userDetail.avt),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayOut.getMailLayout(
        context,
        Container(
          width: double.infinity,
          height: double.infinity,
          color: ColorConstant.VIOLET,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      "Upload avartar",
                      style: TextStyle(
                          color: ColorConstant.WHITE,
                          fontFamily: "Open Sans",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: ColorConstant.LIGHT_VIOLET,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    showImage(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          Container(
                            height: 50,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              gradient: ColorConstant.RAINBOW_BUTTON,
                            ),
                            child: FlatButton(
                              child: Text("Choose image", style:StyleConstant.btnLargeStyle ),
                              onPressed: chooseImage,
                            ),),

                      Container(
                        height: 50,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: ColorConstant.GREY,
                        ),
                        child: FlatButton(
                          child: Text("Upload", style:StyleConstant.btnLargeStyle ),
                          onPressed: startUpload,
                        ),)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        "USER",
        "UploadImage");
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../ButtonGradientLarge.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File _image;
  String _uploadedFileURL;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        uploadFile();
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  Widget showImage(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      _uploadedFileURL != null
          ? Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage("https://bkkaruncloud.b-cdn.net/wp-content/uploads/2019/04/da-nang-to-nha-trang.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            )
          : Container(),
      Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _image == null ? Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _uploadedFileURL == null
                        ? AssetImage(ImageConstant.NO_IMAGE)
                        : NetworkImage(
                            _uploadedFileURL,
                          ),
                    fit: BoxFit.cover,
                  ),
                  // border: Border.all(color: Colors.white70, width: 4),
                ),
              ) : Container(
                width: 180,
                height: 180,
//                decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  image: DecorationImage(
//                    image: Image.asset(snapshot.data),
//                    fit: BoxFit.cover,
//                  ),
//                  // border: Border.all(color: Colors.white70, width: 4),
//                ),
              ),
            ],
          ),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 30,
                color: Colors.black,
              ),
              onPressed: chooseFile,
            ),
            width: 45,
            height: 45,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
        ],
      ),
    ]);
  }

  DateTime selectedDate = DateTime.now();

  Widget _SaveBtn() {
    return ButtonGradientLarge(
        StringConstant.SAVE_CHANGES, () => {uploadFile()});
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    if (ConstantVar.userDetail != null) {
    return MainLayOut.getMailLayout(
        context,
        Container(
          color: ColorConstant.VIOLET,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                showImage(context),
                _SaveBtn()
//                      Container(
//                        padding: EdgeInsets.symmetric(
//                            horizontal: 10.0, vertical: 20.0),
//                        child: Form(
//                          key: _formKey,
//                          child: Column(children: <Widget>[
//                            TextFieldWidget.buildTextField(
//                                StringConstant.USERNAME,
//                                StringConstant.USERNAME_HINT,
//                                Icon(Icons.account_circle, color: Colors.white),
//                                TextInputType.text,
//                                usernameController),
//                            TextFieldWidget.buildTextField(
//                                StringConstant.EMAIL,
//                                StringConstant.EMAIL_HINT,
//                                Icon(Icons.email, color: Colors.white),
//                                TextInputType.text,
//                                emailController),
//                            TextFieldWidget.buildTextField(
//                                StringConstant.FULL_NAME,
//                                StringConstant.FULL_NAME_HINT,
//                                Icon(Icons.assessment, color: Colors.white),
//                                TextInputType.text,
//                                fullNameController),
//                            TextFieldWidget.buildTextField(
//                                StringConstant.PHONE,
//                                StringConstant.PHONE_HINT,
//                                Icon(Icons.phone, color: Colors.white),
//                                TextInputType.text,
//                                phoneController),
//                            TextFieldWidget.buildTextField(
//                                StringConstant.ADDRESS,
//                                StringConstant.ADDRESS_HINT,
//                                Icon(Icons.assignment, color: Colors.white),
//                                TextInputType.text,
//                                addressController),
//                          ]),
//                        ),
//                      ),
//                      _SaveBtn(),
//                      SizedBox(
//                        height: MediaQuery.of(context).size.height * 0.1,
//                      )
              ],
            ),
          ),
        ),
        "USER",
        "Edit Profile");
//    } else {
//      return LoginScreen(handel: "");
//    }
  }
}

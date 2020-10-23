import 'dart:convert';
import 'dart:io';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/User/ChooseProfile.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../modal.dart';
import '../ButtonGradientLarge.dart';
import 'UploadAvartar.dart';
import 'UploadImage.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  startUpload(BuildContext context) {
    if (null == tmpFile) {
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    print(tmpFile.path + fileName);
    _uploadFileAsFormData(context, tmpFile.path, fileName);
  }

  Future<void> _uploadFileAsFormData(
      BuildContext context, String path, String fileName) async {
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
      if (response.statusCode == 200) {
        Modal.showSimpleCustomDialog(context, "Upload Successfull!", null);
      } else {
        Modal.showSimpleCustomDialog(context, "Upload fail!", null);
      }
    } catch (err) {
      print('uploading error: $err');
    }
  }

  bool isUploadImageLoading = false;

  Widget showImage(BuildContext context) {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          startUpload(context);
          return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(UrlConstant.IMAGE +
                            "photo1528790532372-1528790532372684051980-15889023877795083171.jpg"),
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
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(snapshot.data),
                          fit: BoxFit.cover,
                        ),
                        // border: Border.all(color: Colors.white70, width: 4),
                      ),
                    )
                  ],
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: chooseImage,
                  ),
                  width: 45,
                  height: 45,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                ),
              ],
            ),
          ]);
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(UrlConstant.IMAGE +
                            "photo1528790532372-1528790532372684051980-15889023877795083171.jpg"),
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
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ConstantVar.userDetail.avt == null
                              ? AssetImage(ImageConstant.NO_IMAGE)
                              : NetworkImage(UrlConstant.IMAGE +
                                  ConstantVar.userDetail.avt),
                          fit: BoxFit.cover,
                        ),
                        // border: Border.all(color: Colors.white70, width: 4),
                      ),
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
                    onPressed: chooseImage,
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
      },
    );
  }

  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Widget _SaveBtn() {
    return ButtonGradientLarge(
        StringConstant.SAVE_CHANGES, () => {postUserDetail()});
  }

  Future<http.Response> postUserDetail() async {
    final http.Response response = await http.put(
      UrlConstant.EDIT,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + ConstantVar.jwt,
      },
      body: jsonEncode(<String, String>{
        "username": usernameController.text,
        "fullName": fullNameController.text,
        "password": passwordController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "password": "123"
      }),
    );
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChooseProfile()));
      UserDetail.fetchUserDetail(ConstantVar.jwt);
    } else {
      Modal.showSimpleCustomDialog(context, "Not found", "");
    }
    return response;
  }

  @override
  initState() {
    super.initState();
    UserDetail.fetchUserDetail(ConstantVar.jwt).then((value) => setState(() {
          usernameController.text = ConstantVar.userDetail.username;
          fullNameController.text = ConstantVar.userDetail.fullName;
          addressController.text = ConstantVar.userDetail.address;
          phoneController.text = ConstantVar.userDetail.phone;
          emailController.text = ConstantVar.userDetail.email;
          isLoading = false;
        }));
    if (ConstantVar.userDetail != null) {
      usernameController.text = ConstantVar.userDetail.username;
      fullNameController.text = ConstantVar.userDetail.fullName;
      addressController.text = ConstantVar.userDetail.address;
      phoneController.text = ConstantVar.userDetail.phone;
      emailController.text = ConstantVar.userDetail.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ConstantVar.userDetail != null) {
      return !isLoading
          ? MainLayOut.getMailLayout(
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
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            TextFieldWidget.buildTextField(
                                StringConstant.USERNAME,
                                StringConstant.USERNAME_HINT,
                                Icon(Icons.account_circle, color: Colors.white),
                                TextInputType.text,
                                usernameController),
                            TextFieldWidget.buildTextField(
                                StringConstant.EMAIL,
                                StringConstant.EMAIL_HINT,
                                Icon(Icons.email, color: Colors.white),
                                TextInputType.text,
                                emailController),
                            TextFieldWidget.buildTextField(
                                StringConstant.FULL_NAME,
                                StringConstant.FULL_NAME_HINT,
                                Icon(Icons.assessment, color: Colors.white),
                                TextInputType.text,
                                fullNameController),
                            TextFieldWidget.buildTextField(
                                StringConstant.PHONE,
                                StringConstant.PHONE_HINT,
                                Icon(Icons.phone, color: Colors.white),
                                TextInputType.text,
                                phoneController),
                            TextFieldWidget.buildTextField(
                                StringConstant.ADDRESS,
                                StringConstant.ADDRESS_HINT,
                                Icon(Icons.assignment, color: Colors.white),
                                TextInputType.text,
                                addressController),
                          ]),
                        ),
                      ),
                      _SaveBtn(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ],
                  ),
                ),
              ),
              "USER",
              "Edit Profile")
          : Loading(type: "USER", title: "Edit Profile");
    } else {
      return LoginScreen(handel: "");
    }
  }
}

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../modal.dart';
import '../ButtonGradientLarge.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var _imageUrl = null;
  bool isUploadAvatar = false;
  String sDate = "";

  final _formKey = GlobalKey<FormState>();

  Widget _SaveBtn() {
    return ButtonGradientLarge(
        StringConstant.SAVE_CHANGES,
        () => {
              ConstantVar.user.username = usernameController.text,
              ConstantVar.user.email = emailController.text,
              ConstantVar.currentUser.email = emailController.text,
              ConstantVar.currentUser.login = usernameController.text,
              updateUser(ConstantVar.currentUser)
                  .then((updatedUser) {})
                  .catchError((error) {}),
              setState(() => {isUploadAvatar = true}),
              uploadFile().then((value) => {
                Modal.showSimpleCustomDialog(context, "Update profile successful", null)
              })
            });
  }

  @override
  initState() {
    super.initState();
    usernameController.text = ConstantVar.user.username;
    emailController.text = ConstantVar.user.email;
    if (ConstantVar.blindSize == 0 && ConstantVar.volunteerSize == 0) {
      User.getSizeUser().then((value) => {
            setState(() {
              ConstantVar.blindSize = value['blind'];
              ConstantVar.volunteerSize = value['volunteer'];
            })
          });
    }

    if (ConstantVar.user != null) {
      var date =
          new DateTime.fromMillisecondsSinceEpoch(ConstantVar.user.createTime);
      final df = new DateFormat('dd/MM/yyyy');
      sDate = df.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ConstantVar.user != null && ConstantVar.currentUser != null) {
      return !isUploadAvatar
          ? MainLayOut.getMailLayout(
              context,
              Container(
                color: ColorConstant.VIOLET,
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorConstant.LIGHT_VIOLET,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 15),
                                  blurRadius: 15),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, -10),
                                  blurRadius: 10)
                            ]),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: ConstantVar.user.avatarUrl ==
                                                      "" &&
                                                  _imageUrl == null
                                              ? AssetImage(
                                                  ImageConstant.NO_IMAGE)
                                              : NetworkImage(_imageUrl != null
                                                  ? _imageUrl
                                                  : ConstantVar.user.avatarUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                            color: Colors.white70, width: 2),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5, bottom: 5),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {chooseAndUploadImage()},
                                  ),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              ConstantVar.user.username,
                              style: StyleConstant.bigTxtStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Member since ${sDate}",
                              style: StyleConstant.colorTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            ConstantVar.user.role == StringConstant.VOLUNTEER
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              (ConstantVar.user.numHelp + 100)
                                                  .toString(),
                                              style: TextStyle(
                                                  color: ColorConstant.WHITE,
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              StringConstant.NUM_HELPED,
                                              style:
                                                  StyleConstant.colorTextStyle,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 45,
                                        color: Colors.white,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 30),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              (ConstantVar.user.point + 100)
                                                  .toString(),
                                              style: TextStyle(
                                                  color: ColorConstant.WHITE,
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              StringConstant.POINTED_HELPED,
                                              style:
                                                  StyleConstant.colorTextStyle,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                (ConstantVar.blindSize + 100)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: ColorConstant.WHITE,
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                StringConstant.BLINDS,
                                                style: StyleConstant
                                                    .colorTextStyle,
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 1,
                                            height: 45,
                                            color: Colors.white,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                (ConstantVar.volunteerSize +
                                                        100)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: ColorConstant.WHITE,
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                StringConstant.VOLUNTEERS,
                                                style: StyleConstant
                                                    .colorTextStyle,
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 1,
                                            height: 45,
                                            color: Colors.white,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                (ConstantVar.volunteerSize +
                                                        100)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: ColorConstant.WHITE,
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                StringConstant.HELPED,
                                                style: StyleConstant
                                                    .colorTextStyle,
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      Container(
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
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
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

  chooseAndUploadImage() async {
    setState(() {
      isUploadAvatar = true;
    });
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      uploadFileFireBase(image);
    });
  }

  void uploadFileFireBase(_image) async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/avatar${ConstantVar.user.id}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        print("file url " + fileURL);
        _imageUrl = fileURL;
        isUploadAvatar = false;
        ConstantVar.user.avatarUrl = fileURL;
        Modal.showSimpleCustomDialog(
            context, "Upload avatar successfull!", null);
        uploadFile();
      });
    });
  }

  Future<void> uploadFile() async {
    await User.updateUserProfile(ConstantVar.user).then((value) => {
          _imageUrl = null,
          setState(() => {isUploadAvatar = false})
        });
  }
}

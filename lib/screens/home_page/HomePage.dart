import 'dart:convert';

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/detect_object/home.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/Room.dart';
import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/call_video/call_screen.dart';
import 'package:bymyeyefe/screens/call_video/utils/call_manager.dart';
import 'package:bymyeyefe/screens/call_video/utils/configs.dart' as utils;
import 'package:bymyeyefe/screens/room/ListRoom.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constant/ColorConstant.dart';
import '../../modal.dart';
import '../ButtonGradientLarge.dart';

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Homepage();
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String url;
  bool _isLoginContinues = false;
  int blindSize = 0;
  int volunteerSize = 0;
  var _imageUrl = null;
  bool isUploadAvatar = false;
  String sDate = "";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _initConferenceConfig();
    if (CubeChatConnection.instance.systemMessagesManager == null) {
      _loginToCC(ConstantVar.currentUser);
      _isLoginContinues = true;
    } else {
      _initCalls();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          receiveCall(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          getListRoom();
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          receiveCall(message);
        },
      );
    }

    if (ConstantVar.blindSize == 0 && ConstantVar.volunteerSize == 0) {
      User.getSizeUser().then((value) => {
        setState(() {
          blindSize = value['blind'];
          volunteerSize = value['volunteer'];
          ConstantVar.blindSize = blindSize;
          ConstantVar.volunteerSize = volunteerSize;
        })
      });
    } else {
      blindSize = ConstantVar.blindSize;
      volunteerSize = ConstantVar.volunteerSize;
    }

    if (ConstantVar.user != null) {
      var date =
      new DateTime.fromMillisecondsSinceEpoch(ConstantVar.user.createTime);
      final df = new DateFormat('dd/MM/yyyy');
      sDate = df.format(date);
    }
  }

  void receiveCall(message) {
    json.decode(message);
    if (message['data'].roomId) {
      ConversationCallScreen(ConstantVar.currentCall, message['data'].roomId,
          message['data'].roomId, false);
    }
  }

  void getListRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListRoom(),
      ),
    );
  }

  _loginToCC(CubeUser user) {
    if (CubeSessionManager.instance.isActiveSessionValid()) {
      _loginToCubeChat(user);
    } else {
      createSession(user).then((cubeSession) {
        _loginToCubeChat(user);
      }).catchError(_processLoginError);
    }
  }

  void _loginToCubeChat(CubeUser user) {
    CubeChatConnection.instance.login(user).then((cubeUser) {
      setState(() {
        _isLoginContinues = false;
      });
      ConstantVar.currentUser = cubeUser;
      _initCalls();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          receiveCall(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          getListRoom();
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          receiveCall(message);
        },
      );
    }).catchError(_processLoginError);
  }

  void _processLoginError(exception) {
    setState(() {
      _isLoginContinues = false;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Error"),
            content:
            Text("Something went wrong during reconnect to ConnectyCube"),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListRoom(),
                    ),
                  ))
            ],
          );
        });
  }

  void _initConferenceConfig() {
    ConferenceConfig.instance.url = utils.SERVER_ENDPOINT;
  }

  void _initCalls() {
    if (CubeChatConnection.instance.systemMessagesManager == null) {
      _loginToCC(ConstantVar.currentUser);
      _isLoginContinues = true;
    } else {
      ConstantVar.callClient = ConferenceClient.instance;
      ConstantVar.callManager = CallManager.instance;
      ConstantVar.callManager.onReceiveNewCall =
          (roomId, participantIds, name) {
        _showIncomingCallScreen(roomId, participantIds, name);
      };

      ConstantVar.callManager.onCloseCall = () {
        ConstantVar.currentCall = null;
      };
    }
  }

  void _showIncomingCallScreen(String roomId, List<int> participantIds, name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncomingCallScreen(roomId, participantIds, name),
      ),
    );
  }

  Widget _howToCallBtn() {
    return ConstantVar.user.role != StringConstant.BLIND
        ? ButtonGradientLarge(StringConstant.HOW_TO_CALL, () {
      //to do
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListRoom()));
    })
        : Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10, bottom: 5),
          padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: ColorConstant.RAINBOW_BUTTON,
          ),
          child: FlatButton(
            child: Text(StringConstant.SPECIAL_CALL,
                style: StyleConstant.btnLargeStyle),
            onPressed: () => {_startCall()},
          ),
        ));
  }

  void _startCall() async {
    if (ConstantVar.currentUser != null) {
      ConstantVar.currentCall = await ConstantVar.callClient
          .createCallSession(ConstantVar.currentUser.id);

      Room.create();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationCallScreen(ConstantVar.currentCall,
              ConstantVar.currentUser.id.toString(), [], false),
        ),
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstantVar.currentUser != null && ConstantVar.user != null
        ? !_isLoginContinues && !isUploadAvatar
        ? MainLayOut.getMailLayout(
        context,
        ConstantVar.user.role == StringConstant.VOLUNTEER
            ? Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(
              color: ColorConstant.VIOLET,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: ColorConstant.LIGHT_VIOLET,
                        borderRadius: BorderRadius.circular(5),
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
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: ConstantVar.user
                                          .avatarUrl ==
                                          "" &&
                                          _imageUrl == null
                                          ? AssetImage(
                                          ImageConstant.NO_IMAGE)
                                          : NetworkImage(
                                          _imageUrl != null
                                              ? _imageUrl
                                              : ConstantVar.user
                                              .avatarUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                        color: Colors.white70,
                                        width: 2),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: 5, bottom: 5),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () =>
                                {chooseAndUploadImage()},
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
                        ConstantVar.user.role ==
                            StringConstant.VOLUNTEER
                            ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    (ConstantVar.user.numHelp +
                                        100)
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                        ColorConstant.WHITE,
                                        fontSize: 27,
                                        fontWeight:
                                        FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    StringConstant.NUM_HELPED,
                                    style: StyleConstant
                                        .colorTextStyle,
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
                                    (ConstantVar.user.point +
                                        100)
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                        ColorConstant.WHITE,
                                        fontSize: 27,
                                        fontWeight:
                                        FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    StringConstant
                                        .POINTED_HELPED,
                                    style: StyleConstant
                                        .colorTextStyle,
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
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      (blindSize + 100)
                                          .toString(),
                                      style: TextStyle(
                                          color: ColorConstant
                                              .WHITE,
                                          fontSize: 27,
                                          fontWeight:
                                          FontWeight.w500),
                                      textAlign:
                                      TextAlign.center,
                                    ),
                                    Text(
                                      StringConstant.BLINDS,
                                      style: StyleConstant
                                          .colorTextStyle,
                                      textAlign:
                                      TextAlign.center,
                                    )
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 20),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      (volunteerSize + 100)
                                          .toString(),
                                      style: TextStyle(
                                          color: ColorConstant
                                              .WHITE,
                                          fontSize: 27,
                                          fontWeight:
                                          FontWeight.w500),
                                      textAlign:
                                      TextAlign.center,
                                    ),
                                    Text(
                                      StringConstant.VOLUNTEERS,
                                      style: StyleConstant
                                          .colorTextStyle,
                                      textAlign:
                                      TextAlign.center,
                                    )
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 20),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      (volunteerSize + 100)
                                          .toString(),
                                      style: TextStyle(
                                          color: ColorConstant
                                              .WHITE,
                                          fontSize: 27,
                                          fontWeight:
                                          FontWeight.w500),
                                      textAlign:
                                      TextAlign.center,
                                    ),
                                    Text(
                                      StringConstant.HELPED,
                                      style: StyleConstant
                                          .colorTextStyle,
                                      textAlign:
                                      TextAlign.center,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              ConstantVar.user.role != StringConstant.BLIND
                  ? Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 15.0),
                  decoration: BoxDecoration(
                      color: ColorConstant.LIGHT_VIOLET,
                      borderRadius: BorderRadius.circular(5),
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
                  child: Column(
                    children: [
                      Text(
                        "The My Angel Eyes Network",
                        style: StyleConstant.bigTxtStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                (blindSize + 100).toString(),
                                style: TextStyle(
                                    color:
                                    ColorConstant.WHITE,
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
                          Column(
                            children: [
                              Text(
                                (volunteerSize + 100)
                                    .toString(),
                                style: TextStyle(
                                    color:
                                    ColorConstant.WHITE,
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
                          Column(
                            children: [
                              Text(
                                (volunteerSize + 100)
                                    .toString(),
                                style: TextStyle(
                                    color:
                                    ColorConstant.WHITE,
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
                    ],
                  ))
                  : Container(),
              ConstantVar.user.role == StringConstant.VOLUNTEER
                  ? Expanded(flex: 1, child: Container())
                  : Container(),
              _howToCallBtn(),
              SizedBox(
                height: 60,
              )
            ],
          ),
        )
            : Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(
              left: 20.0, bottom: 60.0, right: 20, top: 20),
          decoration: BoxDecoration(
              color: ColorConstant.VIOLET,
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
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                      gradient: ColorConstant.RAINBOW_BUTTON,
                    ),
                    child: FlatButton(
                      child: Text(StringConstant.DETECT,
                          style: StyleConstant.btnLargeStyle),
                      onPressed: () => {
                      Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HomePage()))
                        },
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                      gradient: ColorConstant.RAINBOW_BUTTON,
                    ),
                    child: FlatButton(
                      child: Text(StringConstant.SPECIAL_CALL,
                          style: StyleConstant.btnLargeStyle),
                      onPressed: () => {_startCall()},
                    ),
                  ))
            ],
          ),
        ),
        "HOME",
        StringConstant.APP_NAME)
        : Loading(
      title: StringConstant.APP_NAME,
      type: "HOME",
    )
        : LoginScreen();
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

  void uploadFile() {
    User.updateUserProfile(ConstantVar.user)
        .then((value) => {_imageUrl = null});
  }
}

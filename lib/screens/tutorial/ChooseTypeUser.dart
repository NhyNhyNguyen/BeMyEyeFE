import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/User.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:flutter/material.dart';

import '../../modal.dart';
import '../ButtonGradientLarge.dart';

class ChooseTypeUser extends StatefulWidget {
  final String handel;

  ChooseTypeUser({Key key, this.handel}) : super(key: key);

  @override
  _ChooseTypeUserScreenState createState() =>
      _ChooseTypeUserScreenState(this.handel);
}

class _ChooseTypeUserScreenState extends State<ChooseTypeUser> {
  int blindSize = 0;
  int volunteerSize = 0;

  @override
  void initState() {
    super.initState();
    initStorage();
    User.getSizeUser().then((value) => {
          setState(() {
            blindSize = value['blind'];
            volunteerSize = value['volunteer'];
          })
        });
  }

  initStorage() async {
    await ConstantVar.storage.ready;
    await ConstantVar.getData();
    await ConstantVar.getUserData();
    setState(() {});
  }

  final String handle;

  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();

  _ChooseTypeUserScreenState(this.handle);

  void onPressedLoginFail(BuildContext context) {
    Modal.showSimpleCustomDialog(context, "Invalid user name pass word!", null);
  }

  Widget _assistanceBtn() {
    return ButtonGradientLarge(StringConstant.BECOME_ASSISTANCE, () {
      //to do
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(type: StringConstant.BLIND)));
    });
  }

  Widget _volunteerBtn() {
    return ButtonGradientLarge(StringConstant.BECOME_VOLUNTEER, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen(type: StringConstant.VOLUNTEER)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstantVar.currentUser == null
        ? MainLayOut.getMailLayout(
            context,
            Container(
              color: ColorConstant.VIOLET,
              width: double.infinity,
              height: double.infinity,
              child: Container(
                padding:
                    EdgeInsets.only(top: 25, bottom: 60.0, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
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
                          Container(
                            width: MediaQuery.of(context).size.height * 0.25,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(ImageConstant.LOGO),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            StringConstant.SLOGAN,
                            style: StyleConstant.bigTxtStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            (blindSize + 100).toString(),
                                            style: TextStyle(
                                                color: ColorConstant.WHITE,
                                                fontSize: 27,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            StringConstant.BLINDS,
                                            style: StyleConstant.colorTextStyle,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        height: 45,
                                        color: Colors.white,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            (volunteerSize + 100).toString(),
                                            style: TextStyle(
                                                color: ColorConstant.WHITE,
                                                fontSize: 27,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            StringConstant.VOLUNTEERS,
                                            style: StyleConstant.colorTextStyle,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        height: 45,
                                        color: Colors.white,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            (volunteerSize + 100).toString(),
                                            style: TextStyle(
                                                color: ColorConstant.WHITE,
                                                fontSize: 27,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            StringConstant.HELPED,
                                            style: StyleConstant.colorTextStyle,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    _assistanceBtn(),
                    _volunteerBtn(),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            "SETTING",
            StringConstant.APP_NAME)
        : Homepage();
  }
}

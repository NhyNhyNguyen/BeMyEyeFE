import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
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
  @override
  void initState() {
    super.initState();
    initStorage();
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
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Image.asset(ImageConstant.LOGO),
                          Text(
                            StringConstant.SLOGAN,
                            style: StyleConstant.bigTxtStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorConstant.LIGHT_VIOLET,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "111111",
                                      style: StyleConstant.normalTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Blind",
                                      style: StyleConstant.colorTextStyle,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 45,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 30),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstant.LIGHT_VIOLET,
                                ),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "11111",
                                      style: StyleConstant.normalTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Volunteers",
                                      style: StyleConstant.colorTextStyle,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

import 'package:bymyeyefe/Loading.dart';
import 'package:bymyeyefe/constant/ColorConstant.dart';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/StringConstant.dart';
import 'package:bymyeyefe/constant/StyleConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:bymyeyefe/model/UserDetail.dart';
import 'package:bymyeyefe/screens/ButtonGradientLarge.dart';
import 'package:bymyeyefe/screens/User/ButtonGradientSmall.dart';
import 'package:bymyeyefe/screens/User/ChoosePage.dart';
import 'package:bymyeyefe/screens/User/DetailScreen.dart';
import 'package:bymyeyefe/screens/User/History.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/ResetPassword.dart';
import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
import 'package:bymyeyefe/screens/User/TextfieldWidget.dart';
import 'package:bymyeyefe/services/dynamic_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../ButtonGradient.dart';
import 'Avatar.dart';
import 'ResetPass.dart';

class ChooseProfile extends StatefulWidget {
  @override
  _ChooseProfile createState() => _ChooseProfile();
}

class _ChooseProfile extends State<ChooseProfile> {
  String type = "profile";
  UserDetail userDetail;
  bool isLoading = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Widget _SaveBtn() {
    return ButtonGradientLarge(
        StringConstant.EDIT,
            () =>
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailScreen()))
        });
  }

  void choseOption(type) {
    setState(() {
      this.type = type;
    });
  }

  @override
  initState() {
    super.initState();
//    ConstantVar.isLogin = false;
//    if(ConstantVar.jwt!="" ){
//      UserDetail.fetchUserDetail(ConstantVar.jwt).then((value) => setState(() {
//        usernameController.text = ConstantVar.userDetail.username;
//        fullNameController.text = ConstantVar.userDetail.fullName;
//        addressController.text = ConstantVar.userDetail.address;
//        phoneController.text = ConstantVar.userDetail.phone;
//        emailController.text = ConstantVar.userDetail.email;
//        isLoading = false;
//      }));
//      if(userDetail!= null){
//        usernameController.text = ConstantVar.userDetail.username;
//        fullNameController.text = ConstantVar.userDetail.fullName;
//        addressController.text = ConstantVar.userDetail.address;
//        phoneController.text = ConstantVar.userDetail.phone;
//        emailController.text = ConstantVar.userDetail.email;
//      }
  }

  @override
  Widget build(BuildContext context) {
//    if (ConstantVar.jwt != null) {
//      return ConstantVar.userDetail != null && !isLoading? MainLayOut.getMailLayout(
//          context,
    return Container(
      color: ColorConstant.VIOLET,
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Avatar(
                imageUrl: "data:image/jpeg;base64,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",
                username: "nhi",
                email: "ddnhi@gmail.com"),
//                  Container(
//                    padding:
//                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//                    child: Form(
//                      key: _formKey,
//                      child: Column(children: <Widget>[
//                        TextFieldWidget.buildTextField(
//                            StringConstant.FULL_NAME,
//                            StringConstant.FULL_NAME_HINT,
//                            Icon(Icons.assessment, color: Colors.white),
//                            TextInputType.text,
//                            fullNameController),
//                        TextFieldWidget.buildTextField(
//                            StringConstant.PHONE,
//                            StringConstant.PHONE_HINT,
//                            Icon(Icons.phone, color: Colors.white),
//                            TextInputType.text,
//                            phoneController),
//                        TextFieldWidget.buildTextField(
//                            StringConstant.ADDRESS,
//                            StringConstant.ADDRESS_HINT,
//                            Icon(Icons.assignment, color: Colors.white),
//                            TextInputType.text,
//                            addressController),
//                      ]),
//                    ),
//                  ),
//                  _SaveBtn(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1,
            )
          ],
        ),
      ),
    );
//    ,
//          "USER",
//          "Profile") : Loading(type: "USER", title: "Profile");
//    } else {
//      return LoginScreen(handel: "");
//    }
//  }
  }
}
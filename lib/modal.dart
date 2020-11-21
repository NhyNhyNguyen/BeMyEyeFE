import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:flutter/material.dart';

import 'constant/ColorConstant.dart';
class Modal{
  static void showSimpleCustomDialog(BuildContext context, String text,String onPressed) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 150.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(child: Text(
                  text,
                  style: TextStyle(color: ColorConstant.BLACK, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                     if( onPressed == null ){
                        Navigator.of(context, rootNavigator: true).pop('dialog');
                      }else{
                       if(onPressed == "LOGIN"){
                         Navigator.of(context, rootNavigator: true).pop('dialog');
                         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                       }else{
                         if(onPressed == "HOME_PAGE"){
                           Navigator.of(context, rootNavigator: true).pop('dialog');
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                         }else{
                           Navigator.of(context, rootNavigator: true).pop('dialog');
                           Navigator.of(context).pop(true);
                         }
                       }
                     }
                    },
                    child: Text(
                      'OK',
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
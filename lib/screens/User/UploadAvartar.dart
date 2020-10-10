import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/ImageConstant.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:flutter/material.dart';
class UploadAvatar extends StatefulWidget {
  final Widget image;
  final Function selected;

  const UploadAvatar({Key key, this.image, this.selected}) : super(key: key);

  @override
  _UploadAvatarState createState() => _UploadAvatarState(this.image, this.selected);
}

class _UploadAvatarState extends State<UploadAvatar> {
  final Widget image;
  final Function selected;

  _UploadAvatarState(this.image, this.selected);

  @override
  Widget build(BuildContext context) {
    return  Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          image,
          Container(
            child: IconButton(
              icon: Icon(Icons.camera_alt,
                size: 30,
                color: Colors.black,),
              onPressed: selected(),
            )
            , width: 45,
            height: 45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey
            ),
          ),
        ]
    );
  }
}

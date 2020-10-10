
import 'package:flutter/material.dart';

class TryTest extends StatelessWidget {
  String type;
  TryTest(this.type);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(type, style: TextStyle(color: Colors.white),)
    );
  }
}

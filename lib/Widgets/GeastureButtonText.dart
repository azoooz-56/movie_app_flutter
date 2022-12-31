import 'package:flutter/material.dart';
var size, height, width;

class GeastureButtonText extends StatelessWidget {
  String type;
  final onPress;
  bool check;
  GeastureButtonText({required this.type,required this.onPress,required this.check});

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: height/54.6, bottom: height/32.8, left:width/27.4, right: 0),
        padding: EdgeInsets.symmetric(vertical: height/60, horizontal:width/27.4),
        child: Text(
          type,
          style: TextStyle(color: check ? Colors.white:Colors.white70),
        ),
        decoration: BoxDecoration(
            color: check ? Color(0xFF4b80f0):Color(0xFF1d1f31),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}

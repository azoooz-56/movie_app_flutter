import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shimmer/shimmer.dart';

var size, height, width;

class ShimmerMovieButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return GestureDetector(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            period: Duration(milliseconds: 1000),
            highlightColor: Color(0xFF141422)!,
            baseColor: Color(0xFF323259),
            child: Container(
              width: width/3.425,
              height: height/5.125,

              margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
        ],
      ),
    );
  }
}

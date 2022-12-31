import 'package:flutter/material.dart';
import 'package:movie_app/Screens/DetailsScreen.dart';
import 'package:movie_app/Screens/homeScreen.dart';
class MovieButtonFirst extends StatelessWidget {
  const MovieButtonFirst({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height/8.2,
        width: width/1.644,
        margin: EdgeInsets.symmetric(horizontal: width/27.4),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assest/images/movie.jpg'),
                fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
      ),
    );
  }
}

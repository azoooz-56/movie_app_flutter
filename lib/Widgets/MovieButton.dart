import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:movie_app/Models/MovieModel.dart';
import 'package:movie_app/Screens/DetailsScreen.dart';
import 'package:movie_app/Services/databaseLite.dart';
import 'package:movie_app/Screens/homeScreen.dart';
class MovieButton extends StatefulWidget {
  Movie movie;
  bool check;
  bool isfav;
  MovieButton({required this.movie , required this.check,required this.isfav});

  @override
  State<MovieButton> createState() => _MovieButtonState();
}

class _MovieButtonState extends State<MovieButton> {


  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailsScreen(movie: widget.movie,isFavBack: widget.isfav,);
        })).then((_) => setState(() {

        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width/3.425,
            height: height/5.125,
            margin: EdgeInsets.only(right: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: NetworkImage(widget.movie.imagePathPoster),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            width: width/3.425,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: AutoSizeText(
                    widget.movie.name,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (DatabaseHelper.instance.isFav(widget.movie)) {
                      DatabaseHelper.instance.remove(widget.movie.id);
                      setState(() {
                        widget.check = false;
                      });
                    } else {
                      print('why');
                      DatabaseHelper.instance.add(widget.movie);
                      setState(() {

                        widget.check = true;;
                      });
                    }
                  },
                  child: Container(
                    width: width/11.7,
                    height: width/11.7,

                    margin: EdgeInsets.only(top: 5, bottom: 10,left: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFF1d1f31),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      widget.check ? Icons.favorite : Icons.favorite_border,
                      color: Color(0xFF4b7ff0),
                      size: width/24,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

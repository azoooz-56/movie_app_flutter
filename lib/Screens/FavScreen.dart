import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:movie_app/Services/databaseLite.dart';
import 'package:movie_app/Widgets/MovieButton.dart';
import 'package:movie_app/Widgets/ShimmerMovieButton.dart';
class FavScreen extends StatefulWidget {

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  var listviewMoviesRows = [];
  bool isLoading =true;
  bool isFinish = false;
  var listviewMoviesRowsShimmer = [];

  void initState() {
    for (int i = 0; i < 20; i++) {
      listviewMoviesRowsShimmer.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerMovieButton(),
            SizedBox(
              width: 50,
            ),
            ShimmerMovieButton()
          ],
        ),
      );
    }

    showMovieRowMovies();
  }

  showMovieRowMovies() async {
    listviewMoviesRows = await DatabaseHelper.instance.getMovies();

    var listviewMoviesRowsGetData = [];
    bool check = true;
    for (int i = 0; i < listviewMoviesRows.length; i+=2) {
      if(i == listviewMoviesRows.length-1){
        check = true;
      }else{
        check = false;
      }
      listviewMoviesRowsGetData.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MovieButton(movie: listviewMoviesRows[i],check:true,isfav: true),
            SizedBox(
              width: 50,
            ),
            check ? Container():MovieButton(movie: listviewMoviesRows[i + 1],check: true,isfav: true),
          ],
        ),
      );
    }
    setState(() {
      print('yess');
      listviewMoviesRows = listviewMoviesRowsGetData;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        print('azooz');
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 20,bottom: 30),
            child: AutoSizeText('Favorite',style: TextStyle(
              fontSize: 30,
              color: Colors.white
            ),),
          ),

          Expanded(
            child: (!isLoading && listviewMoviesRows==0)? Center(child: Text(
              'No Movies',style: TextStyle(
              fontSize: 23,
              color: Colors.white
            ),
            ),):ListView(
              shrinkWrap: true,
              children: isLoading
                  ? List<Widget>.from(listviewMoviesRowsShimmer)
                  : List<Widget>.from(listviewMoviesRows),
            ),
          )

        ],
      ),
    );
  }
}

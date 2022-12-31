import 'package:flutter/material.dart';
import 'package:movie_app/Models/MovieModel.dart';
import 'package:movie_app/Screens/DetailsScreen.dart';
import 'package:movie_app/Services/databaseLite.dart';

import 'package:movie_app/Widgets/GeastureButtonText.dart';
import 'package:movie_app/Widgets/MovieButton.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:movie_app/Widgets/ShimmerMovieButton.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_app/Services/MoviesApis.dart';

var size, height, width;


class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int firstMenu = 0;
  int secMenu = 0;

  bool isLoading = true;

  var movieListFirst = [];
  var movieListSecond = [];
  var listviewMoviesRows = [];
  var listviewMoviesRowsShimmer = [];

  MovieApis api = MovieApis();



  @override
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

    getDataMoviesNow();
    super.initState();
  }

  getDataMoviesNow() async {
    await api.getGenre();
    await DatabaseHelper.instance.getMovies();

    setState(() async {
      movieListFirst = await api.getNowMovies();
      await showMovieRowMovies('');

    });

  }

  showMovieRowMovies(String id) async {
    movieListSecond = await api.getDiscoverMovies(id);
    var listviewMoviesRowsGetData = [];
    for (int i = 0; i < movieListSecond.length; i += 2) {
      listviewMoviesRowsGetData.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MovieButton(movie: movieListSecond[i],check: DatabaseHelper.instance.isFav(movieListSecond[i]),isfav: false),
            SizedBox(
              width: 50,
            ),
            MovieButton(movie: movieListSecond[i + 1],check: DatabaseHelper.instance.isFav(movieListSecond[i+1]),isfav: false),
          ],
        ),
      );
    }
    setState(() {
      print('yess');
      listviewMoviesRows = listviewMoviesRowsGetData;
    });

    await Future.delayed( Duration(milliseconds: 500), () {
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
    print(width);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: width/21, top: height/40, right: width/21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Movies',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Icon(
                  Icons.list,
                  color: Colors.white,
                  size: width/11,
                )
              ],
            ),
          ),
          Row(
            children: [
              GeastureButtonText(
                type: 'Now',
                check: firstMenu == 0 ? true : false,
                onPress: () {
                  setState(() {
                    firstMenu = 0;
                  });
                },
              ),
              GeastureButtonText(
                type: 'Popular',
                check: firstMenu == 1 ? true : false,
                onPress: () {
                  setState(() {
                    firstMenu = 1;
                    movieListFirst = MovieApis.moviesPopular;
                  });
                },
              ),
              GeastureButtonText(
                type: 'Soon',
                check: firstMenu == 2 ? true : false,
                onPress: () {
                  setState(() {
                    firstMenu = 2;
                    movieListFirst = MovieApis.moviesSoon;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: height/5.4,
            child: ScrollSnapList(
              itemBuilder: isLoading ? _ShimmerbuildListItem : _buildListItem,
              itemCount: isLoading ? 20 : movieListFirst.length,
              initialIndex: 10,
              itemSize:  width/1.6,
              onItemFocus: (index) {},
              dynamicItemSize: true,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding:  EdgeInsets.only(left: width/20.55),
            child: AutoSizeText(
              'Categories',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            height: height/9.64,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MovieApis.genresMovie.length,
                padding: EdgeInsets.only(right: width/20.55),
                itemBuilder: (BuildContext context, int index) {
                  return GeastureButtonText(
                    type: MovieApis.genresMovie[index].name,
                    check: secMenu == index ? true : false,
                    onPress: () {
                      setState(() {
                        secMenu = index;
                        showMovieRowMovies(MovieApis.genresMovie[index].id);
                      });
                    },
                  );
                }),
          ),
          Expanded(
            child: ListView(
              children: isLoading
                  ? List<Widget>.from(listviewMoviesRowsShimmer)
                  : List<Widget>.from(listviewMoviesRows),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Movie movie = movieListFirst[index];
    return SizedBox(
        width: width/1.6,
        height: height/3.28,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailsScreen(
                movie: movie,
                isFavBack: false,
              );
            }));
          },
          child: Container(
            child: Padding(
              padding:  EdgeInsets.all(width/20.55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      movie.name,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      movie.getGenre(),
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
            height: height/3.28,
            width: width/1.6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(movie.imagePathBackdrop),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ));
  }

  Widget _ShimmerbuildListItem(BuildContext context, int index) {
    return Shimmer.fromColors(
      period: Duration(milliseconds: 1000),
      highlightColor: Color(0xFF141422)!,
      baseColor: Color(0xFF323259),
      child: SizedBox(
          width: width/1.6,
          height: height/3.2,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              child: Padding(
                padding:  EdgeInsets.all(width/20.55),
              ),
              height: height/8.2,
              width: width/1.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          )),
    );
  }
}

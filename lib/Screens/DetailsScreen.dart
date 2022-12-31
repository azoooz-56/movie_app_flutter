import 'package:flutter/material.dart';
import 'package:movie_app/Models/MovieModel.dart';
import 'package:movie_app/Screens/FavScreen.dart';
import 'package:movie_app/Screens/homepage.dart';
import 'package:movie_app/Services/CreditsApi.dart';
import 'package:movie_app/Services/databaseLite.dart';
import 'package:movie_app/const.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:movie_app/Screens/homeScreen.dart';

class DetailsScreen extends StatefulWidget {
  Movie movie;
  bool isFavBack;

  DetailsScreen({required this.movie, required this.isFavBack});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool checkIcon = false;
  List CastsList = [];

  @override
  void initState() {
    // TODO: implement initState
    isFavMovie();
    getCastFromApis();
    super.initState();
  }

  isFavMovie() {
    if (DatabaseHelper.instance.isFav(widget.movie)) {
      setState(() {
        checkIcon = true;
      });
    } else {
      setState(() {
        checkIcon = false;
      });
    }
  }

  getCastFromApis() async {
    CreditApis apis = CreditApis(widget.movie);

    List c = await apis.getCastsApis();
    print(CastsList.length);
    print(CastsList);

    setState(() {
      CastsList = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(CastsList.length);

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: height / 2.5,
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(width / 20.55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => widget.isFavBack
                                    ? SafeArea(child: HomePage())
                                    : SafeArea(child: HomePage()),
                              ),
                            );
                          },
                          child: BlurryContainer(
                              child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (DatabaseHelper.instance.isFav(widget.movie)) {
                              DatabaseHelper.instance.remove(widget.movie.id);
                              setState(() {
                                checkIcon = false;
                              });
                            } else {
                              print('why');
                              DatabaseHelper.instance.add(widget.movie);
                              setState(() {
                                checkIcon = true;
                                ;
                              });
                            }
                          },
                          child: BlurryContainer(
                              child: Icon(
                            checkIcon ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          )),
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.movie.imagePathBackdrop),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 20, left: width / 15, right: width / 10),
                  child: AutoSizeText(
                    widget.movie.name,
                    maxFontSize: 35,
                    minFontSize: 20,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 65, left: width / 15, right: width / 10),
                  child: AutoSizeText(
                    widget.movie.getGenre() + "   " + widget.movie.getDate(),
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                Container(
                  height: height / 8.63,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height / 65, left: width / 15, right: width / 20),

                    child: AutoSizeText(
                      widget.movie.description,
                      minFontSize: 5,
                      maxFontSize: 12,
                      style: TextStyle(color: Colors.white54),
                    ),

                    // child: Flexible(
                    //   child: Text(
                    //     widget.movie.description,
                    //     style: TextStyle(color: Colors.white54),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 60, left: width / 15, right: width / 10),
                  child: AutoSizeText(
                    'Top Cast ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  height: height / 7,
                  margin:
                      EdgeInsets.only(top: height / 60, bottom: height / 32.8),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: CastsList.length,
                      padding: EdgeInsets.only(right: width / 20),
                      itemBuilder: (BuildContext context, int index) {
                        print('yes');
                        return Padding(
                          padding: EdgeInsets.only(left: width / 20),
                          child: Container(
                            width: width / 5,
                            child: AvatarCast(
                              name: CastsList[index].name,
                              path: CastsList[index].pathImage,
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AvatarCast extends StatelessWidget {
  String name;
  String path;

  AvatarCast({required this.name, required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(path),
          ),
        ),
        SizedBox(
          height: height / 90,
        ),
        Flexible(
          child: AutoSizeText(
            name,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
                fontSize: 5, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}

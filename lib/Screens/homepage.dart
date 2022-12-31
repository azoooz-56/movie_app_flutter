import 'package:flutter/material.dart';
import 'package:movie_app/Screens/DetailsScreen.dart';
import 'package:movie_app/Screens/FavScreen.dart';
import 'package:movie_app/Widgets/GeastureButtonText.dart';
import 'package:movie_app/Widgets/MovieButton.dart';
import 'package:movie_app/Widgets/MovieButtonFirst.dart';
import 'package:movie_app/Screens/homeScreen.dart';
import 'package:movie_app/const.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int _selectedIndex = 0;

  final _bottomNavigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home,),
      label: ('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline_sharp),
      label: ('Favorite'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: ('Settings'),
    ),
  ];

  final _bottomNavigationBarActions = <Widget>[
    HomeWidget(),
    FavScreen(),
    //SettingsScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),

        child: BottomNavigationBar(
          elevation: 0,
          // to get rid of the shadow
          backgroundColor: backgroundColor.withOpacity(0.95),
          items: _bottomNavigationBarItems,
          currentIndex: _selectedIndex,
          fixedColor: Color(0xFF12cdd9),
          unselectedItemColor: Color(0xFF92929d),

          onTap: (int index) {
            setState(() {
              if(index == 2){
                _selectedIndex = 0;
              }else{
                _selectedIndex = index;
              }
            });
          },
        ),
      ),
      body: _bottomNavigationBarActions[_selectedIndex],
    );
  }

}

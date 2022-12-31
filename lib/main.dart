import 'package:flutter/material.dart';
import 'package:movie_app/Screens/homepage.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,

        backgroundColor: Color(0xFF121421)

      ),
      home: SafeArea(child:  HomePage()),
    );
  }
}
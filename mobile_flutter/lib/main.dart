import 'package:flutter/material.dart';
import 'app/screens/home/home.dart';

main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proffy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff8257E5),
        primaryColorLight: Color(0xff9871F5),
        buttonColor: Color(0xff04D361),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            bodyText1: TextStyle(
          fontSize: 16,
          color: Colors.white,
        )),
      ),
      home: HomeScreen(),
    );
  }
}

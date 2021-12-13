import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        color: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark)),
    textTheme: const TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ));

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF232526),
  //iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.grey),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    color: Color(0xFF232526),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF232526),
      statusBarBrightness: Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  ),
);

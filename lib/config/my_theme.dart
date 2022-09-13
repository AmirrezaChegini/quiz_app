import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'PO',
    scaffoldBackgroundColor: Constants.purple,
    appBarTheme: AppBarTheme(
      backgroundColor: Constants.purpleLight,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Constants.white,
        fontSize: 17,
        fontFamily: 'PO',
      ),
      headline2: TextStyle(
        color: Constants.purple,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: Constants.white,
      selectedTileColor: Constants.orange,
      selectedColor: Constants.white,
      textColor: Constants.purple,
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.orange,
        minimumSize: Size(85, 40),
        textStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'PO',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

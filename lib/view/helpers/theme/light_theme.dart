import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    accentColor: const Color.fromRGBO(33, 121, 255, 1),
    primaryColor: const Color.fromRGBO(33, 121, 255, 1),
    textTheme: const TextTheme(
        caption: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(61, 61, 61, 0.5),
        ),
        subtitle1:
            TextStyle(color: Color.fromRGBO(61, 61, 61, 1), fontSize: 14),
        bodyText1: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(61, 61, 61, 1),
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(61, 61, 61, 1),
        ),
        headline5: TextStyle(
          fontSize: 26,
          color: Color.fromRGBO(61, 61, 61, 1),
        ),
        button: TextStyle(
          fontSize: 16,
          color: Colors.white,
        )),
    canvasColor: Colors.white,
    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
    inputDecorationTheme: const InputDecorationTheme(
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(246, 16, 45, 1)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      helperStyle: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(61, 61, 61, 1),
      ),
      labelStyle: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(61, 61, 61, 1),
      ),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, color: Color.fromRGBO(233, 233, 233, 1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, color: Color.fromRGBO(144, 188, 255, 1)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromRGBO(250, 135, 149, 1)),
      ),
      contentPadding: EdgeInsets.all(4),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(61, 61, 61, 1),
      shape: StadiumBorder(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: Color.fromRGBO(61, 61, 61, 1),
      ),
      unselectedLabelStyle: TextStyle(color: Color.fromRGBO(157, 160, 165, 1)),
      selectedItemColor: Color.fromRGBO(61, 61, 61, 1),
      unselectedItemColor: Color.fromRGBO(157, 160, 165, 1),
      selectedIconTheme: IconThemeData(
        color: Color.fromRGBO(61, 61, 61, 1),
      ),
      unselectedIconTheme: IconThemeData(
        color: Color.fromRGBO(157, 160, 165, 1),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      padding: EdgeInsets.symmetric(vertical: 8),
      minWidth: 275,
      buttonColor: Color.fromRGBO(61, 61, 61, 1),
      shape: StadiumBorder(),
    ));

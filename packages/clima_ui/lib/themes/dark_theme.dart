import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  iconTheme: const IconThemeData(color: Colors.white),
  snackBarTheme: const SnackBarThemeData(backgroundColor: Color(0xFFE6E6E6)),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFF171717),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF80D8FE),
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.grey.shade300),
    subtitle2: TextStyle(color: Colors.grey.shade500),
  ),
  popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF202125)),
  dialogBackgroundColor: const Color(0xFF202125),
  toggleableActiveColor: const Color(0xFF80D8FE),
  accentColor: const Color(0xFF80D8FE),
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
    actionsIconTheme: IconThemeData(color: Colors.white),
    color: Colors.black,
    brightness: Brightness.dark,
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF80D8FE),
  ),
  popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF2C2C2C)),
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

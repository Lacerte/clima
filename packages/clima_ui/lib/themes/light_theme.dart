import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  iconTheme: const IconThemeData(color: Color(0xFF757575)),
  snackBarTheme: const SnackBarThemeData(backgroundColor: Color(0xFF6F6F6F)),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFFFAFAFA),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
  toggleableActiveColor: const Color(0xFF1A73E9),
  accentColor: const Color(0xFF2396F1),
  primaryColor: const Color(0xFF2396F1),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Color(0xFF212121)),
    subtitle2: TextStyle(color: Color(0xFF757575)),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    textTheme: TextTheme(subtitle1: TextStyle(color: Color(0xFF212121))),
    color: Color(0xFFFFFFFF),
    actionsIconTheme: IconThemeData(color: Color(0xFF000000)),
    iconTheme: IconThemeData(color: Color(0xFF000000)),
    brightness: Brightness.light,
  ),
);

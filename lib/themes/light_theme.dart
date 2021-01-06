import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
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
  toggleableActiveColor: ThemeData.light().accentColor,
  scaffoldBackgroundColor: const Color(0xFFF2F2F2),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    textTheme: TextTheme(subtitle1: TextStyle(color: Colors.grey.shade900)),
    color: const Color(0xFFF2F2F2),
    actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
    iconTheme: IconThemeData(color: Colors.grey.shade900),
    brightness: Brightness.light,
  ),
);

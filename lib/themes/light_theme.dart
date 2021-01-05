import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
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

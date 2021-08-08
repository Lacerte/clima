import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  iconTheme: const IconThemeData(color: Color(0xFF5F6267)),
  snackBarTheme: const SnackBarThemeData(backgroundColor: Color(0xFF202125)),
  toggleableActiveColor: const Color(0xFF1A73E9),
  accentColor: const Color(0xFF1A73E9),
  primaryColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Color(0xFF3C4043)),
    subtitle2: TextStyle(color: Color(0xFF5F6267)),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    textTheme: TextTheme(subtitle1: TextStyle(color: Color(0xFF212121))),
    color: Color(0xFFFFFFFF),
    actionsIconTheme: IconThemeData(color: Color(0xFF5F6267)),
    iconTheme: IconThemeData(color: Color(0xFF5F6267)),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFFFFFFF),
      statusBarColor: Color(0xFFFFFFFF),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clima_theme.dart';

ThemeData blackTheme = ThemeData.dark().copyWith(
  // For some reason, the brightness seems to be wrong if it's not set
  // explicitly.
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: Color(0xFF9BA0A6)),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF202125),
    contentTextStyle: TextStyle(color: Color(0xFFE9EAEE)),
  ),
  popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF202125)),
  dialogBackgroundColor: const Color(0xFF202125),
  toggleableActiveColor: const Color(0xFF89B4F8),
  accentColor: const Color(0xFF89B4F8),
  primaryColor: const Color(0xFF000000),
  scaffoldBackgroundColor: const Color(0xFF000000),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Color(0xFFE9EAEE)),
    subtitle2: TextStyle(color: Color(0xFF9BA0A6)),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    iconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
    textTheme: TextTheme(subtitle1: TextStyle(color: Color(0xFFFFFFFF))),
    actionsIconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
    color: Color(0xFF000000),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF000000),
      statusBarColor: Color(0xFF000000),
    ),
  ),
);

const blackClimaTheme = ClimaThemeData(
  loadingIndicatorColor: Colors.white,
  sheetPillColor: Color(0xFF5F6267),
);

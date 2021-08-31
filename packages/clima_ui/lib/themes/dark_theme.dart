import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clima_theme.dart';

ThemeData darkGreyTheme = ThemeData.dark().copyWith(
  // For some reason, the brightness seems to be wrong if it's not set
  // explicitly.
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: Color(0xFF9BA0A6)),
  popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF36373B)),
  dialogBackgroundColor: const Color(0xFF202125),
  toggleableActiveColor: const Color(0xFF89B4F8),
  accentColor: const Color(0xFF89B4F8),
  colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xFF89B4F8)),
  primaryColor: const Color(0xFF202125),
  scaffoldBackgroundColor: const Color(0xFF202125),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    contentTextStyle: TextStyle(color: Color(0xFF3C4043)),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Color(0xFFE9EAEE)),
    subtitle2: TextStyle(color: Color(0xFF9BA0A6)),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    iconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
    textTheme: TextTheme(subtitle1: TextStyle(color: Color(0xFFE9EAEE))),
    actionsIconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
    color: Color(0xFF202125),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF202125),
      statusBarColor: Color(0xFF202125),
    ),
  ),
);

const darkGreyClimaTheme = ClimaThemeData(
  loadingIndicatorColor: Colors.white,
  sheetPillColor: Color(0xFF5F6267),
);

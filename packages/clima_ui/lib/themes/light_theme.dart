/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clima_theme.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  // For some reason, the brightness seems to be wrong if it's not set
  // explicitly.
  brightness: Brightness.light,
  iconTheme: const IconThemeData(color: Color(0xFF5F6267)),
  toggleableActiveColor: const Color(0xFF1A73E9),
  colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xFF1A73E9)),
  primaryColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF202125),
    actionTextColor: Color(0xFF89B4F8),
    contentTextStyle: TextStyle(color: Color(0xFFE9EAEE)),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Color(0xFF3C4043)),
    subtitle2: TextStyle(color: Color(0xFF5F6267)),
    bodyText2: TextStyle(color: Color(0xFF9BA0A6)),
    caption: TextStyle(color: Color(0xFF6D7174)),
    headline5: TextStyle(color: Color(0xFF212121)),
  ),
  primaryTextTheme: const TextTheme(
    titleSmall: TextStyle(color: Color(0xFF212121)),
    titleMedium: TextStyle(color: Color(0xFF212121)),
    titleLarge: TextStyle(color: Color(0xFF212121)),
  ),
  bannerTheme: const MaterialBannerThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    contentTextStyle: TextStyle(
      color: Color(0xFF3C4043),
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    titleTextStyle: TextStyle(color: Color(0xFF212121)),
    backgroundColor: Color(0xFFFFFFFF),
    actionsIconTheme: IconThemeData(color: Color(0xFF5F6267)),
    iconTheme: IconThemeData(color: Color(0xFF5F6267)),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFFFFFFF),
      statusBarColor: Color(0xFFFFFFFF),
    ),
  ),
);

const lightClimaTheme = ClimaThemeData(
  loadingIndicatorColor: Colors.black,
  sheetPillColor: Color(0xFFDBDCE0),
);

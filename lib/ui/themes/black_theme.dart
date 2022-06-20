/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clima_theme.dart';

final blackTheme = ThemeData.dark().copyWith(
  // For some reason, the brightness seems to be wrong if it's not set
  // explicitly.
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: Color(0xFF9BA0A6)),
  popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF202125)),
  dialogBackgroundColor: const Color(0xFF202125),
  toggleableActiveColor: const Color(0xFF89B4F8),
  colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xFF89B4F8)),
  primaryColor: const Color(0xFF000000),
  scaffoldBackgroundColor: const Color(0xFF000000),
  snackBarTheme: const SnackBarThemeData(
    actionTextColor: Color(0xFF89B4F8),
    backgroundColor: Color(0xFF202125),
    contentTextStyle: TextStyle(color: Color(0xFFE9EAEE)),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Color(0xFFE9EAEE)),
    subtitle2: TextStyle(color: Color(0xFF9BA0A6)),
  ),
  bannerTheme: const MaterialBannerThemeData(
    backgroundColor: Color(0xFF000000),
    contentTextStyle: TextStyle(
      color: Color(0xFFE9EAEE),
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    iconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
    titleTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
    actionsIconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
    backgroundColor: Color(0xFF000000),
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

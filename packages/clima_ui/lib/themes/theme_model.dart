import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeModel extends ChangeNotifier {
  ThemeModel() {
    _isDarkTheme = false;
    _loadFromPrefs();
  }

  final String key = 'theme';
  SharedPreferences _prefs;
  bool _isDarkTheme;

  bool get isDarkTheme => _isDarkTheme;

  ThemeData setTheme() {
    setBarsColor();
    if (_isDarkTheme) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }

  void setLightTheme() {
    _isDarkTheme = false;
    setBarsColor();
    _saveToPrefs();

    notifyListeners();
  }

  void setDarkTheme() {
    _isDarkTheme = true;
    setBarsColor();
    _saveToPrefs();

    notifyListeners();
  }

  void setBarsColor() {
    if (_isDarkTheme) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFF2F2F2),
        statusBarColor: Color(0xFFF2F2F2),
      ));
    }
  }

  Future<void> _initPrefs() async {
    _prefs ??= _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _isDarkTheme);
  }
}

// final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
// bool isDark = brightnessValue == Brightness.dark;

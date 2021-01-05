import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';

import '../main.dart';
import 'black_theme.dart';
import 'light_theme.dart';

class ThemeModel extends ChangeNotifier {
  bool isDarkModeEnabled = false;
  ThemeData currentTheme = lightTheme;

  void setLightTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFF2F2F2),
        statusBarColor: Color(0xFFF2F2F2),
      ),
    );
    isDarkModeEnabled = false;
    currentTheme = lightTheme;

    notifyListeners();
  }

  void setBlackTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
      ),
    );
    isDarkModeEnabled = true;
    currentTheme = blackTheme;

    notifyListeners();
  }

  void setDarkTheme() {}

  Color checkMarkColor(ThemeModel appThemeState) {
    if (appThemeState.currentTheme == blackTheme) {
      return Colors.grey.shade900;
    } else if (appThemeState.currentTheme == lightTheme) {
      return Colors.white;
    } else {
      // Return color for dark theme
      return Colors.white;
    }
  }

  Color cardColor(ThemeModel themeState) {
    if (themeState.currentTheme == blackTheme) {
      return const Color(0xFF171717);
    } else if (themeState.currentTheme == lightTheme) {
      return const Color(0xFFFAFAFA);
    }
    return const Color(0xFFFAFAFA);
  }

  Color textFieldFillColor() {
    if (ThemeModel().currentTheme == blackTheme) {
      return const Color(0xFF171717);
    } else if (ThemeModel().currentTheme == lightTheme) {
      return const Color(0xFFFAFAFA);
    }
    return const Color(0xFFFAFAFA);
  }

  Color spinkitColor(ThemeModel themeState) {
    if (themeState.currentTheme == blackTheme) {
      return Colors.white;
    } else if (themeState.currentTheme == lightTheme) {
      return Colors.black;
    }
    return Colors.white;
  }

  Color snackBarColor() {
    if (ThemeModel().currentTheme == blackTheme) {
      return const Color(0xFFE6E6E6);
    } else if (ThemeModel().currentTheme == lightTheme) {
      return const Color(0xFF6F6F6F);
    }
    return const Color(0xFFE6E6E6);
  }

  void barsColor() {
    if (ThemeModel().currentTheme == blackTheme) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.black,
        ),
      );
    } else if (ThemeModel().currentTheme == lightTheme) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFFF2F2F2),
          statusBarColor: Color(0xFFF2F2F2),
        ),
      );
    }
  }
}

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appThemeState = context.read(themeStateNotifier);
    return Switch(
      value: appThemeState.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          appThemeState.setBlackTheme();
        } else {
          appThemeState.setLightTheme();
        }
      },
    );
  }
}

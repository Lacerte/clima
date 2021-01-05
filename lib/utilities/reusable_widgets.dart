import 'package:clima/main.dart';
import 'package:clima/themes/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ReusableWidgets extends StatelessWidget {
  const ReusableWidgets({this.cardChild});

  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeModel().cardColor(_themeState),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardChild,
          ),
        ),
      ),
    );
  }
}

Future<SnackBar> snackBar(
    {String text, SnackBarAction action, int duration = 2}) async {
  return SnackBar(
    backgroundColor: ThemeModel().snackBarColor(),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: duration),
    content: Text(text),
    action: action,
  );
}

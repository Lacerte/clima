import 'package:clima_core/failure.dart';
import 'package:clima_ui/main.dart';
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
          color: _themeState.isDarkTheme
              ? const Color(0xFF171717)
              : const Color(0xFFFCFCFC),
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

SnackBar snackBar({String text, SnackBarAction action, int duration}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: duration ?? 2),
    content: Text(text),
    action: action,
  );
}

SnackBar failureSnackbar({
  @required Failure failure,
  VoidCallback onRetry,
  int duration,
}) {
  final text = () {
    if (failure is NoConnection) {
      return 'No network connection';
    } else if (failure is FailedToParseResponse) {
      return 'Could not parse response';
    } else if (failure is ServerDown) {
      return "Can't connect to server";
    } else if (failure is InvalidCityName) {
      return 'Invalid city name';
    } else {
      throw ArgumentError('Did not expect $failure');
    }
  }();

  return snackBar(
    text: text,
    duration: duration ?? 86400,
    action: onRetry != null
        ? SnackBarAction(label: 'Retry', onPressed: onRetry)
        : null,
  );
}

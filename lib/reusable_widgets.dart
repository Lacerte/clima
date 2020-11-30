import 'package:flutter/material.dart';

class ReusableWidgets extends StatelessWidget {
  const ReusableWidgets({this.cardChild});

  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF171717),
          //color: Colors.grey[900],
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
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: duration),
    content: Text(text),
    action: action,
  );
}

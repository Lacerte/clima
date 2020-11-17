import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class autoSizeText extends StatelessWidget {
  const autoSizeText({this.text, this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

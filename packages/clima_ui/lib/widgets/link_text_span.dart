import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

InlineSpan linkTextSpan({
  required String text,
  required String url,
  required BuildContext context,
}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: Theme.of(context).colorScheme.secondary,
    ),
    recognizer: TapGestureRecognizer()..onTap = () => launch(url),
  );
}

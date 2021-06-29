import 'package:clima_core/failure.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart'
    show themeProvider, AppTheme;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showFailureSnackBar(
  BuildContext context, {
  @required Failure failure,
  VoidCallback onRetry,
  int duration,
}) {
  final theme = context.read(themeProvider);

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
  final messenger = ScaffoldMessenger.of(context);
  messenger.removeCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(
          color: () {
            switch (theme) {
              case AppTheme.light:
                return const Color(0xFFE9EAEE);

              case AppTheme.black:
                return const Color(0xFFE9EAEE);

              case AppTheme.darkGrey:
                return const Color(0xFF3C4043);
            }
          }(),
        ),
      ),
      duration: Duration(seconds: duration ?? 86400),
      action: onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: Theme.of(context).accentColor,
              onPressed: onRetry,
            )
          : null,
    ),
  );
}

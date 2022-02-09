/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/failure.dart';
import 'package:flutter/material.dart';

void showFailureSnackBar(
  BuildContext context, {
  required Failure failure,
  VoidCallback? onRetry,
  int? duration,
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

  final messenger = ScaffoldMessenger.of(context);
  messenger.removeCurrentSnackBar();
  showSnackBar(
    context,
    text: text,
    actionText: 'Retry',
    onPressed: onRetry,
  );
}

void showSnackBar(
  BuildContext context, {
  required String text,
  String? actionText,
  VoidCallback? onPressed,
  int? duration,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.removeCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      duration: Duration(seconds: duration ?? 86400),
      action: onPressed != null
          ? SnackBarAction(
              label: actionText!,
              textColor: Theme.of(context).colorScheme.secondary,
              onPressed: onPressed,
            )
          : null,
    ),
  );
}

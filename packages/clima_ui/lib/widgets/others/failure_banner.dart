/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/failure.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

class FailureBanner extends HookWidget {
  const FailureBanner({required this.onRetry, required this.failure, Key? key})
      : super(key: key);

  final void Function() onRetry;

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      forceActionsBelow: true,
      content: Text(
        () {
          if (failure is NoConnection) {
            return 'Looks like you lost your connection. Please check it and try again.';
          } else if (failure is FailedToParseResponse) {
            return "Looks like we're having trouble parsing the response. Please try again.";
          } else if (failure is ServerDown) {
            return 'Looks like the server is down. Please try again later.';
          } else if (failure is InvalidCityName) {
            return 'Looks like an invalid city name. Please check it and try again.';
          } else {
            throw ArgumentError('Did not expect $failure');
          }
        }(),
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
              ? 13.sp
              : 7.sp,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onRetry,
          child: Text(
            'RETRY',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}

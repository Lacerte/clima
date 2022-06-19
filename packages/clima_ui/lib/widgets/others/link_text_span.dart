/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

InlineSpan linkTextSpan({
  required String text,
  required String url,
  required BuildContext context,
}) =>
    TextSpan(
      text: text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () => launchUrl(Uri.parse(url)),
    );

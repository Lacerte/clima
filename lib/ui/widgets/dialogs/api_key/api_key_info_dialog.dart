/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/ui/widgets/others/link_text_span.dart';
import 'package:flutter/material.dart';

class ApiKeyInfoDialog extends StatelessWidget {
  const ApiKeyInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textSpanStyle = TextStyle(
      color: Theme.of(context).textTheme.subtitle1!.color,
    );
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Clima receives data from ',
                  style: textSpanStyle,
                  children: [
                    linkTextSpan(
                      context: context,
                      text: 'OpenWeatherMap',
                      url: 'https://openweathermap.org',
                    ),
                    TextSpan(
                      text:
                          "'s free service, which is limited to only 1000 calls per day. You could receive your own 1000 calls by registering your API key for free ",
                      style: textSpanStyle,
                    ),
                    linkTextSpan(
                      context: context,
                      text: 'here',
                      url: 'https://openweathermap.org/price',
                    ),
                    TextSpan(
                      text:
                          '. Otherwise, calls are shared between all Clima users who use the default API key.',
                      style: textSpanStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

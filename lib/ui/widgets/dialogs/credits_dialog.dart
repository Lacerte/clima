/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/ui/utilities/constants.dart';
import 'package:clima/ui/widgets/others/link_text_span.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textSpanStyle = TextStyle(
      color: Theme.of(context).textTheme.subtitle1!.color,
    );
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Center(
                child: Image.asset(
                  height: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 6.h
                      : 4.h,
                  () {
                    switch (Theme.of(context).brightness) {
                      case Brightness.dark:
                        return 'assets/openweather_logo_dark.png';

                      case Brightness.light:
                        return 'assets/openweather_logo_light.png';
                    }
                  }(),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "The app's weather data is provided by ",
                    style: textSpanStyle,
                  ),
                  linkTextSpan(
                    context: context,
                    text: 'OpenWeather',
                    url: 'https://openweathermap.org',
                  ),
                  TextSpan(
                    text: '.',
                    style: textSpanStyle,
                  ),
                ],
              ),
            ),
            Divider(
              color:
                  Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
            ),
            RichText(
              text: TextSpan(
                text: "The app logo's ",
                style: textSpanStyle,
                children: [
                  linkTextSpan(
                    context: context,
                    text: 'icon',
                    url: 'https://www.iconfinder.com/iconsets/tiny-weather-1',
                  ),
                  TextSpan(
                    text: ' is designed by ',
                    style: textSpanStyle,
                  ),
                  linkTextSpan(
                    context: context,
                    text: 'Paolo Spot Valzania',
                    url: 'https://linktr.e/paolospotvalzania',
                  ),
                  TextSpan(
                    text: ', licensed under the ',
                    style: textSpanStyle,
                  ),
                  linkTextSpan(
                    context: context,
                    text: 'CC BY 3.0',
                    url: 'https://creativecommons.org/licenses/by/3.0/',
                  ),
                  TextSpan(
                    text: ' / Placed on top of a light blue background.',
                    style: textSpanStyle,
                  ),
                ],
              ),
            ),
            Divider(
              color:
                  Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
            ),
            RichText(
              text: TextSpan(
                text: 'The ',
                style: textSpanStyle,
                children: [
                  linkTextSpan(
                    context: context,
                    text: 'weather icons',
                    url:
                        'https://www.amcharts.com/free-animated-svg-weather-icons/',
                  ),
                  TextSpan(
                    text: ' used inside the app are designed by ',
                    style: textSpanStyle,
                  ),
                  linkTextSpan(
                    context: context,
                    text: 'amCharts',
                    url: 'https://www.amcharts.com/',
                  ),
                  TextSpan(
                    text: ' and licensed under the ',
                    style: textSpanStyle,
                  ),
                  linkTextSpan(
                    context: context,
                    text: 'CC BY 4.0',
                    url: 'https://creativecommons.org/licenses/by/4.0/',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

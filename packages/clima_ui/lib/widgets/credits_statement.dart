import 'package:flutter/material.dart';

import 'settings_widgets.dart';

class CreditsStatement extends StatelessWidget {
  const CreditsStatement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textSpanStyle = TextStyle(
      color: Theme.of(context).textTheme.subtitle1!.color,
    );
    return Column(
      children: [
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
          color: Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
        ),
        RichText(
          text: TextSpan(
            text: 'The app design is heavily inspired by ',
            style: textSpanStyle,
            children: [
              TextSpan(
                text: "LonelyCpp's ",
                style: textSpanStyle,
              ),
              linkTextSpan(
                context: context,
                text: 'design',
                url: 'https://github.com/LonelyCpp/flutter_weather',
              ),
              TextSpan(
                text: ', which is licensed under the ',
                style: textSpanStyle,
              ),
              linkTextSpan(
                context: context,
                text: 'Expat License.',
                url: 'https://mit-license.org/',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

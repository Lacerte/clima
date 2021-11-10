import 'package:clima_ui/widgets/link_text_span.dart';
import 'package:flutter/material.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({Key? key}) : super(key: key);

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
    );
  }
}

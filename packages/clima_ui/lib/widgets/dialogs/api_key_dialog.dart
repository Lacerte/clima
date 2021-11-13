import 'package:clima_ui/widgets/link_text_span.dart';
import 'package:flutter/material.dart';

class ApiKeyDialog extends StatelessWidget {
  const ApiKeyDialog({Key? key}) : super(key: key);

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
                  text: 'Clima receives data from the free service of ',
                  style: textSpanStyle,
                  children: [
                    linkTextSpan(
                      context: context,
                      text: 'OpenWeatherMap',
                      url: 'https://openweathermap.org',
                    ),
                    TextSpan(
                      text:
                          ', which is limited to 1000 calls per day. You could register your own API key for free ',
                      style: textSpanStyle,
                    ),
                    linkTextSpan(
                      context: context,
                      text: 'here ',
                      url: 'https://openweathermap.org/price',
                    ),
                    TextSpan(
                      text:
                          'to get your own 1000 calls. Otherwise, calls are shared between all users of Clima.',
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

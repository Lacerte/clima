import 'package:clima_ui/screens/weather_screen.dart';
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'value_tile.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends HookWidget {
  const CurrentConditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = useProvider(weatherStateNotifierProvider.state).weather;

    if (weather == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: () {
              if (MediaQuery.of(context).size.aspectRatio <= 9 / 19) {
                return 32.0;
              }
              return 24.0;
            }(),
            top: () {
              if (MediaQuery.of(context).size.aspectRatio <= 9 / 18) {
                return 16.0;
              } else if (MediaQuery.of(context).size.height <= 610) {
                return 0.0;
              }
              return 24.0;
            }(),
          ),
          child: Icon(
            getIconData(weather.iconCode),
            color: Theme.of(context).textTheme.subtitle1.color,
            size: 70,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: () {
              if (MediaQuery.of(context).size.aspectRatio <= 9 / 18) {
                return 8.0;
              }
              return 0.0;
            }(),
          ),
          child: Text(
            '${weather.temperature.round()}°',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueTile('max', '${weather.maxTemperature.round()}°'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Container(
                  width: 1,
                  height: 35,
                  color:
                      Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
                ),
              ),
            ),
            ValueTile('min', '${weather.minTemperature.round()}°'),
          ],
        ),
      ],
    );
  }
}

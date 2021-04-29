import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:clima_ui/utilities/weather_icons.dart';
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
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                weather.cityName.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  color: Theme.of(context).textTheme.subtitle1.color,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            child: Text(
              weather.description.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w100,
                letterSpacing: 5,
                fontSize: 15,
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Icon(
            getIconData(weather.iconCode),
            color: Theme.of(context).textTheme.subtitle1.color,
            size: 70,
          ),
        ),
        Expanded(
          flex: () {
            // It's bounded between 9/16 and 9/14 to account for MediaQuery's margin of error.
            if (MediaQuery.of(context).size.aspectRatio >= 9 / 18 &&
                MediaQuery.of(context).size.aspectRatio <= 9 / 14) {
              return 4;
            }
            return 3;
          }(),
          child: Text(
            '${weather.temperature.round()}°',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ValueTile('max', '${weather.maxTemperature.round()}°'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Container(
                    width: 1,
                    height: 35,
                    color: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .color
                        .withAlpha(65),
                  ),
                ),
              ),
              ValueTile('min', '${weather.minTemperature.round()}°'),
            ],
          ),
        ),
      ],
    );
  }
}

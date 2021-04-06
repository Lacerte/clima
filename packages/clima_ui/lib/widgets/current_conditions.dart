import 'package:clima_ui/screens/location_screen.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Icon(
            getIconData(weather.iconCode),
            color: Theme.of(context).textTheme.subtitle1.color,
            size: 70,
          ),
        ),
        Text(
          '${weather.temperature.round()}°',
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w100,
            color: Theme.of(context).textTheme.subtitle1.color,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile('max', '${weather.maxTemperature.round()}°'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                width: 1,
                height: 32,
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(50),
              ),
            ),
          ),
          ValueTile('min', '${weather.minTemperature.round()}°'),
        ]),
      ],
    );
  }
}

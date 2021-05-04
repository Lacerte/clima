import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'current_conditions_widgets.dart';
import 'forecast_widget.dart';
import 'value_tile.dart';

class WeatherWidget extends HookWidget {
  const WeatherWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = useProvider(weatherStateNotifierProvider).weather;

    if (weather == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
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
              Text(
                weather.description.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  letterSpacing: 5,
                  fontSize: 15,
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              const CurrentConditions(),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
        ),
        Flexible(
          flex: 2,
          child: ForecastHorizontal(),
        ),
        Divider(
          color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueTile('wind speed', '${weather.windSpeed.round()} km/h'),
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
                ValueTile(
                  'sunrise',
                  DateFormat('h:mm a').format(
                    weather.sunrise.toUtc().add(weather.timeZoneOffset),
                  ),
                ),
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
                ValueTile(
                  'sunset',
                  DateFormat('h:mm a').format(
                    weather.sunset.toUtc().add(weather.timeZoneOffset),
                  ),
                ),
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
                ValueTile('humidity', '${weather.humidity}%'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

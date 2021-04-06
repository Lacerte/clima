import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';

import 'forecast_horizontal_widget.dart';
import 'value_tile.dart';
import 'weather_swipe_pager.dart';

class WeatherWidget extends HookWidget {
  const WeatherWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = useProvider(weatherStateNotifierProvider.state).weather;

    if (weather == null) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            child: SizedBox.shrink(),
          ),
          Expanded(
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
                const WeatherSwipePager(),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(60),
          ),
          Expanded(
            flex: 2,
            child: ForecastHorizontal(),
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(60),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueTile('wind speed', '${weather.windSpeed.round()} m/s'),
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
                          .withAlpha(60),
                    ),
                  ),
                ),
                ValueTile(
                  'sunrise',
                  DateFormat('h:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000)
                        .toUtc()
                        .add(
                          weather.timeZoneOffset,
                        ),
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
                          .withAlpha(60),
                    ),
                  ),
                ),
                ValueTile(
                  'sunset',
                  DateFormat('h:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000)
                        .toUtc()
                        .add(
                          weather.timeZoneOffset,
                        ),
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
                          .withAlpha(60),
                    ),
                  ),
                ),
                ValueTile('humidity', '${weather.humidity}%'),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

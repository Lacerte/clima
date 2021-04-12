import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';

import 'forecast_widget.dart';
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (() {
          if (MediaQuery.of(context).size.aspectRatio <= 9 / 19) {
            return const Spacer(
              flex: 2,
            );
          } else if (MediaQuery.of(context).size.aspectRatio <= 9 / 18) {
            return const Spacer();
          } else if (MediaQuery.of(context).size.aspectRatio <= 3 / 4) {
            return const Spacer();
          } else if (MediaQuery.of(context).size.aspectRatio <= 9 / 16) {
            return const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        }()),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
                top: () {
                  if (MediaQuery.of(context).size.aspectRatio <= 9 / 19) {
                    return 0.0;
                  } else if (MediaQuery.of(context).size.aspectRatio <=
                      9 / 18) {
                    return 24.0;
                  } else if (MediaQuery.of(context).size.height <= 610) {
                    return 8.0;
                  } else {
                    return 16.0;
                  }
                }(),
              ),
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
          ],
        ),
        Flexible(
          flex: 8,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: () {
                if (MediaQuery.of(context).size.aspectRatio <= 9 / 19) {
                  return 16.0;
                } else if (MediaQuery.of(context).size.aspectRatio <= 3 / 4) {
                  return 16.0;
                } else if (MediaQuery.of(context).size.aspectRatio <= 9 / 16) {
                  return 0.0;
                } else if (MediaQuery.of(context).size.aspectRatio <= 9 / 18) {
                  return 8.0;
                }
                return 0.0;
              }(),
            ),
            child: const WeatherSwipePager(),
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
                          .withAlpha(65),
                    ),
                  ),
                ),
                ValueTile(
                  'sunrise',
                  DateFormat('h:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      weather.sunrise * 1000,
                    ).toUtc().add(
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
                          .withAlpha(65),
                    ),
                  ),
                ),
                ValueTile(
                  'sunset',
                  DateFormat('h:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000)
                        .toUtc()
                        .add(weather.timeZoneOffset),
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

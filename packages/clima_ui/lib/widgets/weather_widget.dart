import 'package:clima_domain/entities/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'current_conditions.dart';
import 'forecast_horizontal_widget.dart';
import 'value_tile.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(this.weather, {Key key}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            weather.cityName.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                color: Theme.of(context).textTheme.subtitle1.color,
                fontSize: 25),
          ),
          const SizedBox(
            height: 20,
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
          CurrentConditions(
            weather: weather,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Divider(
              color: Theme.of(context).textTheme.subtitle1.color.withAlpha(50),
            ),
          ),
          ForecastHorizontal(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Divider(
              color: Theme.of(context).textTheme.subtitle1.color.withAlpha(50),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile('wind speed', '${weather.windSpeed.round()} m/s'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(50),
              )),
            ),
            ValueTile(
              'sunrise',
              DateFormat('h:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(50),
              )),
            ),
            ValueTile(
              'sunset',
              DateFormat('h:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(50),
              )),
            ),
            ValueTile('humidity', '${weather.humidity}%'),
          ]),
        ],
      ),
    );
  }
}

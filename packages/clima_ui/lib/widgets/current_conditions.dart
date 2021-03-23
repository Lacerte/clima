import 'package:clima_domain/entities/weather.dart';
import 'package:clima_ui/screens/location_screen.dart';
import 'package:flutter/material.dart';

import 'value_tile.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  const CurrentConditions({Key key, this.weather}) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          getIconData(weather.iconCode),
          color: Theme.of(context).accentColor,
          size: 70,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            '${weather.temperature.round()}°',
            style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w100,
                color: Theme.of(context).accentColor),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile('max', '${weather.maxTemperature.round()}°'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: Theme.of(context).accentColor.withAlpha(50),
            )),
          ),
          ValueTile('min', '${weather.minTemperature.round()}°'),
        ]),
      ],
    );
  }
}

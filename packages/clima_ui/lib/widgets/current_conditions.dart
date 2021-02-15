import 'package:flutter/material.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_ui/screens/location_screen.dart';

import 'value_tile.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  Weather weather;

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
        Text(
          '${weather.temperature.round()}°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: Theme.of(context).accentColor),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile('max', '${weather.maxTemperature.round()}°'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
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

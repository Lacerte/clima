import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'value_tile.dart';

class BottomRow extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final weather = useProvider(weatherStateNotifierProvider).weather;
    if (weather == null) {
      return const SizedBox.shrink();
    }

    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ValueTile(localizations.windSpeedLowercase,
              '${weather.windSpeed.round()} km/h'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                width: 1,
                height: 4.5.h,
                color:
                    Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
              ),
            ),
          ),
          ValueTile(
            localizations.sunriseLowercase,
            DateFormat('h:mm a').format(
              weather.sunrise.toUtc().add(weather.timeZoneOffset),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                width: 1,
                height: 4.5.h,
                color:
                    Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
              ),
            ),
          ),
          ValueTile(
            localizations.sunsetLowercase,
            DateFormat('h:mm a').format(
              weather.sunset.toUtc().add(weather.timeZoneOffset),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                width: 1,
                height: 4.5.h,
                color:
                    Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
              ),
            ),
          ),
          ValueTile(localizations.humidityLowercase, '${weather.humidity}%'),
        ],
      ),
    );
  }
}

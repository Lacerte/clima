import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_ui/screens/weather_screen.dart';
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// Renders a horizontal scrolling list of weather conditions
/// Used to show forecast
/// Shows DateTime, Weather Condition icon and Temperature
class ForecastHorizontal extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final forecastsState = useProvider(f.forecastsStateNotifierProvider.state);

    Forecasts forecasts;

    if (forecastsState is f.Loaded) {
      forecasts = forecastsState.forecasts;
    } else if (forecastsState is f.Loading &&
        forecastsState.forecasts != null) {
      forecasts = forecastsState.forecasts;
    } else if (forecastsState is f.Error && forecastsState.forecasts != null) {
      forecasts = forecastsState.forecasts;
    } else {
      return const SizedBox.shrink();
    }
    return SizedBox(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: forecasts.forecasts.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final forecast = forecasts.forecasts[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat('E, h a').format(
                      forecast.date.toUtc().add(forecast.timeZoneOffset),
                    ),
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .color
                          .withAlpha(130),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Icon(
                      getIconData(forecast.iconCode),
                      color: Theme.of(context).textTheme.subtitle1.color,
                      size: 20,
                    ),
                  ),
                  Text(
                    '${forecast.temperature.round()}°',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1.color,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

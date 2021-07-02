import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_icons/weather_icons.dart';

/// Renders a horizontal scrolling list of weather conditions
/// Used to show forecast
/// Shows DateTime, Weather Condition icon and Temperature
class ForecastHorizontal extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final forecastsState = useProvider(f.forecastsStateNotifierProvider);

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
    return ListView.separated(
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
          padding: EdgeInsets.symmetric(
            vertical: () {
              // It's bounded between 9/16.5 and 9/14.5 to account for MediaQuery's margin of error.
              if (MediaQuery.of(context).size.aspectRatio >= 9 / 16.5 &&
                  MediaQuery.of(context).size.aspectRatio <= 9 / 14.5) {
                return 0.0;
              }
              return 6.0;
            }(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: () {
                  if (MediaQuery.of(context).size.shortestSide <
                      kTabletBreakpoint) {
                    return 8.0;
                  }
                  return 12.0;
                }()),
                child: Text(
                  DateFormat('E, h a').format(
                    forecast.date.toUtc().add(forecast.timeZoneOffset),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle2.color,
                    fontSize: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 11.sp
                        : 8.sp,
                  ),
                ),
              ),
              Expanded(
                child: BoxedIcon(
                  getIconData(forecast.iconCode),
                  color: Theme.of(context).textTheme.subtitle1.color,
                  size: () {
                    switch (forecast.iconCode) {
                      case '03d':
                      case '04d':
                      case '03n':
                      case '04n':
                      case '01n':
                      case '01d':
                        return MediaQuery.of(context).size.shortestSide <
                                kTabletBreakpoint
                            ? 20.sp
                            : 15.sp;
                      default:
                        return MediaQuery.of(context).size.shortestSide <
                                kTabletBreakpoint
                            ? 17.sp
                            : 13.sp;
                    }
                  }(),
                ),
              ),
              Text(
                '${forecast.temperature.round()}°',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 11.sp
                      : 8.sp,
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

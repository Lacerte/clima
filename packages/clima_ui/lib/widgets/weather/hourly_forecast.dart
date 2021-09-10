import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HourlyForecast extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final forecastsState = useProvider(f.forecastsStateNotifierProvider);

    Forecasts forecasts;

    if (forecastsState is f.Loaded) {
      forecasts = forecastsState.forecasts;
    } else if (forecastsState is f.Loading &&
        forecastsState.forecasts != null) {
      forecasts = forecastsState.forecasts!;
    } else if (forecastsState is f.Error && forecastsState.forecasts != null) {
      forecasts = forecastsState.forecasts!;
    } else {
      return const SizedBox.shrink();
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: forecasts.forecasts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final forecast = forecasts.forecasts[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat().add_jm().format(
                      forecast.date.toUtc().add(forecast.timeZoneOffset),
                    ),
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2!.color,
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 11.sp
                      : 8.sp,
                ),
              ),
              SvgPicture.asset(
                getWeatherIcon(forecast.iconCode),
                height: 6.h,
              ),
              Text(
                '${forecast.temperature.round()}°',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 11.sp
                      : 8.sp,
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.invert_colors,
                    color: Theme.of(context).textTheme.subtitle2!.color,
                    size: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 11.sp
                        : 8.sp,
                  ),

                  ///TODO: Add rain chance
                  Text(
                    '15%',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle2!.color,
                      fontSize: MediaQuery.of(context).size.shortestSide <
                              kTabletBreakpoint
                          ? 11.sp
                          : 8.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

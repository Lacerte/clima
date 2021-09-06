import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HourCell extends HookWidget {
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
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: forecasts.forecasts.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.white,
      ),
      itemBuilder: (context, index) {
        final forecast = forecasts.forecasts[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.5.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //TODO: Only display the hour in the forecast
              Text(
                DateFormat.E().add_jm().format(
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
              FaIcon(
                getIconData(forecast.iconCode),
                color: Theme.of(context).iconTheme.color,
                size:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 17.sp
                        : 13.sp,
              ),
              //TODO: Add Humidity Icon
              Text(
                '${forecast.humidity} %',
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
        );
      },
    );
  }
}

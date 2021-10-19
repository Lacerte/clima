import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HourlyForecastsWidget extends HookWidget {
  const HourlyForecastsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hourlyForecasts = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.hourlyForecasts,
      ),
    );
    final timeZoneOffset = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.timeZoneOffset,
      ),
    );
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: hourlyForecasts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final hourlyForecast = hourlyForecasts[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.j().format(
                  hourlyForecast.date.toUtc().add(timeZoneOffset),
                ),
                style: kSubtitle2TextStyle(context),
              ),
              SvgPicture.asset(
                getWeatherIcon(hourlyForecast.iconCode),
                height: 6.h,
              ),
              Text(
                '${hourlyForecast.temperature.round()}°',
                style: kSubtitle1TextStyle(context),
              ),
              Row(
                children: [
                  Icon(
                    Icons.invert_colors,
                    color: Theme.of(context).textTheme.subtitle2!.color,
                    size: kIconSize(context),
                  ),
                  Text(
                    '${(hourlyForecast.pop * 100).round()}%',
                    style: kSubtitle2TextStyle(context),
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

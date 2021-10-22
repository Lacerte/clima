import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/widgets/weather/additional_info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AdditionalInfoWidget extends HookWidget {
  const AdditionalInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWeather = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentWeather,
      ),
    );
    final currentDayForecast = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentDayForecast,
      ),
    );
    final timeZoneOffset = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.timeZoneOffset,
      ),
    );
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: 2.h, top: 2.h, left: 5.w, right: 5.w),
          child: Row(
            children: [
              AdditionalInfoTile(
                title: 'Feels like',
                value: '${currentWeather.tempFeel.round()}°',
              ),
              AdditionalInfoTile(
                title: 'Humidity',
                value: '${currentWeather.humidity}%',
              ),
              AdditionalInfoTile(
                title: 'Wind speed',
                value: '${currentWeather.windSpeed.round()} km/h',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 2.h,
            top: 1.h,
            right: 5.w,
            left: 5.w,
          ),
          child: Row(
            children: [
              AdditionalInfoTile(
                title: 'Clouds',
                value: '${currentWeather.clouds.toString()}%',
              ),
              AdditionalInfoTile(
                title: 'UV Index',
                value: currentWeather.uvIndex.toString(),
              ),
              AdditionalInfoTile(
                title: 'Chance of rain',
                value: '${(currentDayForecast.pop * 100).round()}%',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 3.h,
            top: 1.h,
            right: 5.w,
            left: 5.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdditionalInfoTile(
                title: 'Sunrise',
                value: DateFormat.Hm().format(
                  currentDayForecast.sunrise.toUtc().add(timeZoneOffset),
                ),
              ),
              AdditionalInfoTile(
                title: 'Sunset',
                value: DateFormat.Hm().format(
                  currentDayForecast.sunset.toUtc().add(timeZoneOffset),
                ),
              ),
              AdditionalInfoTile(
                title: 'Pressure',
                value: '${currentWeather.pressure} mbar',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

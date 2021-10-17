import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AdditionalInfo extends HookWidget {
  const AdditionalInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWeather = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentWeather,
      ),
    );
    final timeZoneOffset = useProvider(
      w.fullWeatherStateNotifierProvider.select(
            (state) => state.fullWeather!.timeZoneOffset,
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'FEELS LIKE',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
                Expanded(
                  child: Text(
                    'HUMIDITY',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${currentWeather.tempFeel.round()}°',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                child: Text(
                  '${currentWeather.humidity}%',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'CHANCE OF RAIN',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
                Expanded(
                  child: Text(
                    'PRESSURE',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                ///TODO: Add precipitation
                child: Text(
                  '${} %',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                child: Text(
                  '${currentWeather.pressure} mbar',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'WIND SPEED',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
                Expanded(
                  child: Text(
                    'UV INDEX',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${currentWeather.windSpeed.round()} km/h',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                child: Text(
                  '${currentWeather.uvIndex}',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'SUNRISE',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
                Expanded(
                  child: Text(
                    'SUNSET',
                    style: kMoreDetailsWeatherTitle(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
    DateFormat.Hm().format(
    currentWeather.sunrise.toUtc().add(timeZoneOffset),),
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                child: Text(
                  DateFormat.Hm().format(
                    currentWeather.sunset.toUtc().add(timeZoneOffset),),
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

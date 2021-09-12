import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

class AdditionalInfo extends HookWidget {
  const AdditionalInfo({
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.precipitation,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
    Key? key,
  }) : super(key: key);

  final int feelsLike;
  final int humidity;
  final int windSpeed;
  final int pressure;
  final int precipitation;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;

  @override
  Widget build(BuildContext context) {
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
                  '$feelsLike°',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                child: Text(
                  '$humidity%',
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
                  '$precipitation %',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                ///TODO: Add pressure
                child: Text(
                  '$pressure mbar',
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
                  '$windSpeed km/h',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                ///TODO: Add UV index
                child: Text(
                  '$uvIndex',
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
                ///TODO: Add sunrise
                child: Text(
                  '$sunrise',
                  style: kMoreDetailsWeatherData(context),
                ),
              ),
              Expanded(
                ///TODO: Add sunset
                child: Text(
                  '$sunset',
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

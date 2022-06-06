/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/domain/entities/unit_system.dart';
import 'package:clima/ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima/ui/state_notifiers/unit_system_state_notifier.dart';
import 'package:clima/ui/widgets/weather/additional_info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AdditionalInfoWidget extends ConsumerWidget {
  const AdditionalInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentWeather,
      ),
    );
    final currentDayForecast = ref.watch(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentDayForecast,
      ),
    );
    final timeZoneOffset = ref.watch(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.timeZoneOffset,
      ),
    );

    final unitSystem = ref.watch(
      unitSystemStateNotifierProvider.select(
        (state) => state.unitSystem!,
      ),
    );

    final timeFormat = MediaQuery.of(context).alwaysUse24HourFormat
        ? DateFormat.Hm()
        : DateFormat.jm();

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
                value: '${currentWeather.windSpeed.round()} ${() {
                  switch (unitSystem) {
                    case UnitSystem.metric:
                      return 'km/h';

                    case UnitSystem.imperial:
                      return 'mph';
                  }
                }()}',
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
                title: 'UV index',
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
                value: timeFormat.format(
                  currentDayForecast.sunrise.toUtc().add(timeZoneOffset),
                ),
              ),
              AdditionalInfoTile(
                title: 'Sunset',
                value: timeFormat.format(
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

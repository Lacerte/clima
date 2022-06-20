/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima/ui/utilities/constants.dart';
import 'package:clima/ui/utilities/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HourlyForecastsWidget extends ConsumerWidget {
  const HourlyForecastsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyForecasts = ref.watch(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.hourlyForecasts,
      ),
    );
    final timeZoneOffset = ref.watch(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.timeZoneOffset,
      ),
    );

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 24,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final hourlyForecast = hourlyForecasts[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                    FontAwesomeIcons.droplet,
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

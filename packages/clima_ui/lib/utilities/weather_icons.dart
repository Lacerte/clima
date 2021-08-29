/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

//returns the right weather icon for the right condition.

IconData getIconData(String iconCode) {
  switch (iconCode) {
    case '01d':
      return WeatherIcons.day_sunny;
    case '01n':
      return WeatherIcons.night_clear;
    case '02d':
      return WeatherIcons.day_cloudy;
    case '02n':
      return WeatherIcons.day_cloudy;
    case '03d':
    case '04d':
      return WeatherIcons.day_cloudy_high;
    case '03n':
    case '04n':
      return WeatherIcons.night_clear;
    case '09d':
      return WeatherIcons.day_showers;
    case '09n':
      return WeatherIcons.night_alt_showers;
    case '10d':
      return WeatherIcons.day_showers;
    case '10n':
      return WeatherIcons.night_alt_showers;
    case '11d':
      return WeatherIcons.day_thunderstorm;
    case '11n':
      return WeatherIcons.night_thunderstorm;
    case '13d':
      return WeatherIcons.day_snow;
    case '13n':
      return WeatherIcons.night_snow;
    case '50d':
      return WeatherIcons.day_fog;
    case '50n':
      return WeatherIcons.night_fog;
    default:
      return WeatherIcons.day_sunny;
  }
}

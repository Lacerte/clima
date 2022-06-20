/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

// ignore_for_file: avoid_dynamic_calls

import 'package:clima/data/utils/date_time.dart' as date_time_utils;
import 'package:clima/domain/entities/city.dart';
import 'package:clima/domain/entities/daily_forecast.dart';
import 'package:clima/domain/entities/full_weather.dart';
import 'package:clima/domain/entities/hourly_forecast.dart';
import 'package:clima/domain/entities/unit_system.dart';
import 'package:clima/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class FullWeatherModel extends Equatable {
  const FullWeatherModel(this.fullWeather);

  factory FullWeatherModel.fromJson(
    Map<String, dynamic> json, {
    required City city,
  }) {
    final currentWeatherJson = json['current'];

    return FullWeatherModel(
      FullWeather(
        city: city,
        unitSystem: UnitSystem.metric,
        timeZoneOffset: Duration(seconds: json['timezone_offset'] as int),
        currentWeather: Weather(
          unitSystem: UnitSystem.metric,
          temperature: (currentWeatherJson['temp'] as num).toDouble(),
          tempFeel: (currentWeatherJson['feels_like'] as num).toDouble(),
          // We multiply by 3.6 to convert from m/s to km/h.
          windSpeed: (currentWeatherJson['wind_speed'] as num).toDouble() * 3.6,
          condition: currentWeatherJson['weather'][0]['id'] as int,
          description:
              currentWeatherJson['weather'][0]['description'] as String,
          date:
              date_time_utils.fromUtcUnixTime(currentWeatherJson['dt'] as int),
          iconCode: currentWeatherJson['weather'][0]['icon'] as String,
          humidity: currentWeatherJson['humidity'] as int,
          clouds: currentWeatherJson['clouds'] as int,
          pressure: currentWeatherJson['pressure'] as int,
          uvIndex: (currentWeatherJson['uvi'] as num).toDouble(),
        ),
        dailyForecasts: (json['daily'] as List)
            .map(
              (forecastJson) => DailyForecast(
                unitSystem: UnitSystem.metric,
                maxTemperature: (forecastJson['temp']['max'] as num).toDouble(),
                minTemperature: (forecastJson['temp']['min'] as num).toDouble(),
                date:
                    date_time_utils.fromUtcUnixTime(forecastJson['dt'] as int),
                iconCode: forecastJson['weather'][0]['icon'] as String,
                pop: (forecastJson['pop'] as num).toDouble(),
                sunrise: date_time_utils
                    .fromUtcUnixTime(forecastJson['sunrise'] as int),
                sunset: date_time_utils
                    .fromUtcUnixTime(forecastJson['sunset'] as int),
              ),
            )
            .toList(),
        hourlyForecasts: [
          for (final forecastJson in json['hourly'] as List)
            HourlyForecast(
              unitSystem: UnitSystem.metric,
              date: date_time_utils.fromUtcUnixTime(forecastJson['dt'] as int),
              iconCode: forecastJson['weather'][0]['icon'] as String,
              temperature: (forecastJson['temp'] as num).toDouble(),
              pop: (forecastJson['pop'] as num).toDouble(),
            ),
        ],
      ),
    );
  }

  final FullWeather fullWeather;

  @override
  List<Object?> get props => [fullWeather];
}

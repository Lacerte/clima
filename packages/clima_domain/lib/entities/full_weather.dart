import 'package:clima_domain/entities/daily_forecast.dart';
import 'package:clima_domain/entities/hourly_forecast.dart';
import 'package:equatable/equatable.dart';

import 'city.dart';
import 'weather.dart';

class FullWeather extends Equatable {
  const FullWeather({
    required this.city,
    required this.timeZoneOffset,
    required this.currentWeather,
    required this.dailyForecasts,
    required this.hourlyForecasts,
  });

  final City city;

  final Duration timeZoneOffset;

  final Weather currentWeather;

  final List<DailyForecast> dailyForecasts;

  final List<HourlyForecast> hourlyForecasts;

  DailyForecast get currentDayForecast => dailyForecasts.reduce((a, b) {
        final aDiffCurrent = currentWeather.date.difference(a.date).abs();
        final bDiffCurrent = currentWeather.date.difference(b.date).abs();

        if (aDiffCurrent < bDiffCurrent) {
          return a;
        } else if (bDiffCurrent == aDiffCurrent) {
          if (a.date.weekday == currentWeather.date.weekday) {
            return a;
          }

          return b;
        } else {
          return b;
        }
      });

  @override
  List<Object> get props =>
      [city, timeZoneOffset, currentWeather, dailyForecasts, hourlyForecasts];
}

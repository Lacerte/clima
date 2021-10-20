import 'package:clima_domain/entities/daily_forecast.dart';
import 'package:clima_domain/entities/hourly_forecast.dart';
import 'package:collection/collection.dart';
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

  DailyForecast get currentDayForecast => minBy(
        dailyForecasts.where(
          (forecast) => forecast.date.weekday == currentWeather.date.weekday,
        ),
        (forecast) => forecast.date.difference(currentWeather.date).abs(),
      )!;

  @override
  List<Object> get props =>
      [city, timeZoneOffset, currentWeather, dailyForecasts, hourlyForecasts];
}

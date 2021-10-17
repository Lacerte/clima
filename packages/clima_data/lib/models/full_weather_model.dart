import 'package:clima_data/utils/date_time.dart' as date_time_utils;
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/daily_forecast.dart';
import 'package:clima_domain/entities/full_weather.dart';
import 'package:clima_domain/entities/hourly_forecast.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class FullWeatherModel extends Equatable {
  const FullWeatherModel(this.fullWeather);

  final FullWeather fullWeather;

  factory FullWeatherModel.fromJson(
    Map<String, dynamic> json, {
    required City city,
  }) {
    final currentWeatherJson = json['current'];
    final currentTime = currentWeatherJson['dt'] as int;

    final currentDayForecast = (json['daily'] as List).reduce((a, b) {
      final aDiffCurrent =
          ((currentWeatherJson['dt'] as int) - (a['dt'] as int)).abs();
      final bDiffCurrent =
          ((currentWeatherJson['dt'] as int) - (b['dt'] as int)).abs();

      if (aDiffCurrent < bDiffCurrent) {
        return a;
      } else if (bDiffCurrent == aDiffCurrent) {
        throw Exception("Two daily forecasts can't have the same time");
      } else {
        return b;
      }
    });

    return FullWeatherModel(
      FullWeather(
        city: city,
        timeZoneOffset: Duration(seconds: json['timezone_offset'] as int),
        currentWeather: Weather(
          temperature: (currentWeatherJson['temp'] as num).toDouble(),
          maxTemperature: (currentDayForecast['temp']['max'] as num).toDouble(),
          minTemperature: (currentDayForecast['temp']['min'] as num).toDouble(),
          tempFeel: (currentWeatherJson['feels_like'] as num).toDouble(),
          // We multiply by 3.6 to convert from m/s to km/h.
          windSpeed: (currentWeatherJson['wind_speed'] as num).toDouble() * 3.6,
          condition: currentWeatherJson['weather'][0]['id'] as int,
          description:
              currentWeatherJson['weather'][0]['description'] as String,
          date: date_time_utils.fromUtcUnixTime(currentTime),
          iconCode: currentWeatherJson['weather'][0]['icon'] as String,
          sunrise: date_time_utils
              .fromUtcUnixTime(currentWeatherJson['sunrise'] as int),
          sunset: date_time_utils
              .fromUtcUnixTime(currentWeatherJson['sunset'] as int),
          humidity: currentWeatherJson['humidity'] as int,
          pressure: currentWeatherJson['pressure'] as int,
          uvIndex: (currentWeatherJson['uvi'] as num).toDouble(),
        ),
        dailyForecasts: (json['daily'] as List)
            .map(
              (forecastJson) => DailyForecast(
                maxTemperature: (forecastJson['temp']['max'] as num).toDouble(),
                minTemperature: (forecastJson['temp']['min'] as num).toDouble(),
                date:
                    date_time_utils.fromUtcUnixTime(forecastJson['dt'] as int),
                iconCode: forecastJson['weather'][0]['icon'] as String,
                pop: (forecastJson['pop'] as num).toDouble(),
              ),
            )
            .toList(),
        hourlyForecasts: [
          for (final forecastJson in json['hourly'] as List)
            HourlyForecast(
              date: date_time_utils.fromUtcUnixTime(forecastJson['dt'] as int),
              iconCode: forecastJson['weather'][0]['icon'] as String,
              temperature: forecastJson['temp'] as double,
              pop: (forecastJson['pop'] as num).toDouble(),
            ),
        ],
      ),
    );
  }

  @override
  List<Object?> get props => [fullWeather];
}

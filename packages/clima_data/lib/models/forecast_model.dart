import 'package:equatable/equatable.dart';
import 'package:clima_domain/entities/weather.dart';

class ForecastModel extends Equatable {
  const ForecastModel(this.forecast);

  final Weather forecast;

  factory ForecastModel.fromJson(
    Map<String, dynamic> json, {
    required String cityName,
    required Duration timeZoneOffset,
  }) =>
      ForecastModel(
        Weather(
          temperature: (json['main']['temp'] as num).toDouble(),
          maxTemperature: (json['main']['temp_max'] as num).toDouble(),
          minTemperature: (json['main']['temp_min'] as num).toDouble(),
          tempFeel: (json['main']['feels_like'] as num).toDouble(),
          // We multiply by 3.6 to convert from m/s to km/h.
          windSpeed: (json['wind']['speed'] as num).toDouble() * 3.6,
          condition: json['weather'][0]['id'] as int,
          cityName: cityName,
          description: json['weather'][0]['description'] as String,
          date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
          iconCode: json['weather'][0]['icon'] as String,
          timeZoneOffset: timeZoneOffset,
          sunrise: json['sys']['sunrise'] as int,
          sunset: json['sys']['sunset'] as int,
          humidity: json['main']['humidity'] as int,
        ),
      );

  @override
  List<Object?> get props => [forecast];
}

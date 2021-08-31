import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  /// In degrees Celsius (for now).
  final double temperature;

  /// In kilometers per hour (for now).
  final double windSpeed;

  /// The perceived temperature. Same unit as [temperature].
  final double tempFeel;

  /// Current weather condition (e.g. snow, thunderstorm).
  final int condition;

  /// Maximum temperature at the moment. Same unit as [temperature].
  final double maxTemperature;

  /// Minimum temperature at the moment. Same unit as [temperature].
  final double minTemperature;

  final String cityName;

  /// String describing the current weather condition (e.g. clear sky).
  final String description;
  final String iconCode;

  final DateTime date;
  final DateTime sunrise;
  final DateTime sunset;
  final int humidity;
  final Duration timeZoneOffset;

  const Weather({
    required this.temperature,
    required this.windSpeed,
    required this.tempFeel,
    required this.condition,
    required this.minTemperature,
    required this.maxTemperature,
    required this.cityName,
    required this.description,
    required this.iconCode,
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.timeZoneOffset,
  });

  @override
  List<Object?> get props => [
        temperature,
        windSpeed,
        tempFeel,
        condition,
        minTemperature,
        maxTemperature,
        cityName,
        description,
        iconCode,
        date,
        sunrise,
        sunset,
        humidity,
        timeZoneOffset,
      ];
}

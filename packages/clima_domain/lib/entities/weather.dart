import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime date;

  final DateTime sunrise;

  final DateTime sunset;

  /// In degrees Celsius (for now).
  final double temperature;

  /// In kilometers per hour (for now).
  final double windSpeed;

  /// The perceived temperature. Same unit as [temperature].
  final double tempFeel;

  /// Current weather condition (e.g. snow, thunderstorm).
  final int condition;

  /// Minimum temperature at the moment. Same unit as [temperature].
  final double minTemperature;

  /// Maximum temperature at the moment. Same unit as [temperature].
  final double maxTemperature;

  final int humidity;

  /// In `hPa`.
  final int pressure;

  final double uvIndex;

  /// String describing the current weather condition (e.g. clear sky).
  final String description;

  final String iconCode;

  const Weather({
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.temperature,
    required this.windSpeed,
    required this.tempFeel,
    required this.condition,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
    required this.uvIndex,
    required this.description,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [
        date,
        sunrise,
        sunset,
        temperature,
        windSpeed,
        tempFeel,
        condition,
        minTemperature,
        maxTemperature,
        humidity,
        pressure,
        uvIndex,
        description,
        iconCode,
      ];
}

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime date;

  /// In degrees Celsius (for now).
  final double temperature;

  /// In kilometers per hour (for now).
  final double windSpeed;

  /// The perceived temperature. Same unit as [temperature].
  final double tempFeel;

  /// Current weather condition (e.g. snow, thunderstorm).
  final int condition;

  final int humidity;

  /// In `hPa`.
  final int pressure;

  final double uvIndex;

  /// String describing the current weather condition (e.g. clear sky).
  final String description;

  final String iconCode;

  const Weather({
    required this.date,
    required this.temperature,
    required this.windSpeed,
    required this.tempFeel,
    required this.condition,
    required this.humidity,
    required this.pressure,
    required this.uvIndex,
    required this.description,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [
        date,
        temperature,
        windSpeed,
        tempFeel,
        condition,
        humidity,
        pressure,
        uvIndex,
        description,
        iconCode,
      ];
}

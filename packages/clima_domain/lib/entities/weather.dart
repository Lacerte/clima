import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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


  final int time;
  final int sunrise;
  final int sunset;
  final int humidity;

  const Weather({
    @required this.temperature,
    @required this.windSpeed,
    @required this.tempFeel,
    @required this.condition,
    @required this.minTemperature,
    @required this.maxTemperature,
    @required this.cityName,
    @required this.description,
    @required this.iconCode,
    @required this.time,
    @required this.sunrise,
    @required this.sunset,
    @required this.humidity,
  });

  @override
  List<Object> get props => [
        temperature,
        windSpeed,
        tempFeel,
        condition,
        maxTemperature,
        minTemperature,
        cityName,
        description,
      ];
}

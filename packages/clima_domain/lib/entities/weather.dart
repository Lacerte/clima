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
  final double tempMax;

  /// Minimum temperature at the moment. Same unit as [temperature].
  final double tempMin;

  final String cityName;

  /// String describing the current weather condition (e.g. clear sky).
  final String description;

  const Weather({
    @required this.temperature,
    @required this.windSpeed,
    @required this.tempFeel,
    @required this.condition,
    @required this.tempMin,
    @required this.tempMax,
    @required this.cityName,
    @required this.description,
  });

  @override
  List<Object> get props => [
        temperature,
        windSpeed,
        tempFeel,
        condition,
        tempMax,
        tempMin,
        cityName,
        description,
      ];
}

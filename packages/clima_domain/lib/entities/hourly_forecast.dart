import 'package:equatable/equatable.dart';

class HourlyForecast extends Equatable {
  final DateTime date;

  /// In degrees Celsius (for now).
  final double temperature;

  /// Probability of precipitation.
  final double pop;

  final String iconCode;

  const HourlyForecast({
    required this.date,
    required this.temperature,
    required this.pop,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [date, temperature, pop, iconCode];
}

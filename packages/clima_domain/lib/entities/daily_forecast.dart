import 'package:equatable/equatable.dart';

class DailyForecast extends Equatable {
  final DateTime date;

  /// Minimum temperature at the moment. In degrees Celsius (for now).
  final double minTemperature;

  /// Maximum temperature at the moment. In degrees Celsius (for now).
  final double maxTemperature;

  /// Probability of precipitation.
  final double pop;

  final String iconCode;

  const DailyForecast({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pop,
    required this.iconCode,
  });

  @override
  List<Object?> get props =>
      [date, minTemperature, maxTemperature, pop, iconCode];
}

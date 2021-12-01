/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:equatable/equatable.dart';

class DailyForecast extends Equatable {
  final DateTime date;

  final DateTime sunrise;

  final DateTime sunset;

  /// Minimum temperature at the moment. In degrees Celsius (for now).
  final double minTemperature;

  /// Maximum temperature at the moment. In degrees Celsius (for now).
  final double maxTemperature;

  /// Probability of precipitation.
  final double pop;

  final String iconCode;

  const DailyForecast({
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pop,
    required this.iconCode,
  });

  @override
  List<Object?> get props =>
      [date, sunrise, sunset, minTemperature, maxTemperature, pop, iconCode];
}

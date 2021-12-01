/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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

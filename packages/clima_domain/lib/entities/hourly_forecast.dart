/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_domain/entities/unit_system.dart';
import 'package:clima_domain/utils/unit_conversion.dart';
import 'package:equatable/equatable.dart';

class HourlyForecast extends Equatable {
  final DateTime date;

  final double temperature;

  /// Probability of precipitation.
  final double pop;

  final String iconCode;

  final UnitSystem unitSystem;

  const HourlyForecast({
    required this.date,
    required this.temperature,
    required this.pop,
    required this.iconCode,
    required this.unitSystem,
  });

  @override
  List<Object?> get props => [date, temperature, pop, iconCode, unitSystem];

  HourlyForecast changeUnitSystem(UnitSystem newUnitSystem) {
    if (unitSystem == newUnitSystem) {
      return this;
    }

    final double newTemperature;

    switch (unitSystem) {
      case UnitSystem.imperial:
        newTemperature = convertFahrenheitToCelsius(temperature);
        break;

      case UnitSystem.metric:
        newTemperature = convertCelsiusToFahrenheit(temperature);
    }

    return HourlyForecast(
      pop: pop,
      date: date,
      temperature: newTemperature,
      iconCode: iconCode,
      unitSystem: newUnitSystem,
    );
  }
}

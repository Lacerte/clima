/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/domain/entities/unit_system.dart';
import 'package:clima/domain/utils/unit_conversion.dart';
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.date,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.tempFeel,
    required this.condition,
    required this.humidity,
    required this.clouds,
    required this.pressure,
    required this.uvIndex,
    required this.description,
    required this.iconCode,
    required this.unitSystem,
  });

  final DateTime date;

  final double temperature;

  final double windSpeed;

  final double windDirection;

  /// The perceived temperature. Same unit as [temperature].
  final double tempFeel;

  /// Current weather condition (e.g. snow, thunderstorm).
  final int condition;

  final int humidity;

  /// In percent.
  final int clouds;

  /// In `hPa`.
  final int pressure;

  final double uvIndex;

  final String description;

  final String iconCode;

  final UnitSystem unitSystem;

  @override
  List<Object?> get props => [
        date,
        temperature,
        windSpeed,
        windDirection,
        tempFeel,
        condition,
        humidity,
        clouds,
        pressure,
        uvIndex,
        description,
        iconCode,
        unitSystem,
      ];

  Weather changeUnitSystem(UnitSystem newUnitSystem) {
    if (unitSystem == newUnitSystem) {
      return this;
    }

    final double newTemperature;
    final double newTempFeel;
    final double newWindSpeed;

    switch (unitSystem) {
      case UnitSystem.imperial:
        newTemperature = convertFahrenheitToCelsius(temperature);
        newTempFeel = convertFahrenheitToCelsius(tempFeel);
        newWindSpeed = convertMilesPerHourToKilometersPerHour(windSpeed);
        break;

      case UnitSystem.metric:
        newTemperature = convertCelsiusToFahrenheit(temperature);
        newTempFeel = convertCelsiusToFahrenheit(tempFeel);
        newWindSpeed = convertKilometersPerHourToMilesPerHour(windSpeed);
    }

    return Weather(
      date: date,
      temperature: newTemperature,
      windSpeed: newWindSpeed,
      windDirection: windDirection,
      tempFeel: newTempFeel,
      condition: condition,
      humidity: humidity,
      clouds: clouds,
      pressure: pressure,
      uvIndex: uvIndex,
      description: description,
      iconCode: iconCode,
      unitSystem: newUnitSystem,
    );
  }
}

/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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

  /// In percent.
  final int clouds;

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
    required this.clouds,
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
        clouds,
        pressure,
        uvIndex,
        description,
        iconCode,
      ];
}

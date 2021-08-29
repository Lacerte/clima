/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class Forecasts extends Equatable {
  const Forecasts({
    required this.forecasts,
    required this.cityName,
  });

  final List<Weather> forecasts;

  final String cityName;

  @override
  List<Object?> get props => [forecasts, cityName];
}

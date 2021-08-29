/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_data/utils/date_time.dart' as date_time_utils;
import 'package:clima_domain/entities/forecasts.dart';
import 'package:equatable/equatable.dart';

import 'forecast_model.dart';

class ForecastsModel extends Equatable {
  const ForecastsModel(this.forecasts);

  final Forecasts forecasts;

  factory ForecastsModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>;
    final cityName = json['city']['name'] as String;
    final timeZoneOffset = Duration(seconds: json['city']['timezone'] as int);
    final sunrise =
        date_time_utils.fromUtcUnixTime(json['city']['sunrise'] as int);
    final sunset =
        date_time_utils.fromUtcUnixTime(json['city']['sunset'] as int);

    return ForecastsModel(
      Forecasts(
        cityName: cityName,
        forecasts: list
            .map(
              (json) => ForecastModel.fromJson(
                json as Map<String, dynamic>,
                cityName: cityName,
                timeZoneOffset: timeZoneOffset,
                sunrise: sunrise,
                sunset: sunset,
              ).forecast,
            )
            .toList(),
      ),
    );
  }

  @override
  List<Object?> get props => [forecasts];
}

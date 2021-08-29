/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_data/models/forecast_model.dart';
import 'package:clima_data/utils/date_time.dart' as date_time_utils;
import 'package:clima_domain/entities/weather.dart';
import 'package:test/test.dart';

void main() {
  group('ForecastModel', () {
    test('fromJson', () {
      const json = {
        "dt": 1615118400,
        "main": {
          "temp": 5.29,
          "feels_like": 1.94,
          "temp_min": 5.29,
          "temp_max": 6.05,
          "pressure": 1028,
          "sea_level": 1028,
          "grnd_level": 1024,
          "humidity": 55,
          "temp_kf": -0.76
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "clouds": {"all": 46},
        "wind": {"speed": 1.37, "deg": 0},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2021-03-07 12:00:00"
      };

      final sunrise = date_time_utils.fromUtcUnixTime(1615098752);
      final sunset = date_time_utils.fromUtcUnixTime(1615139446);

      expect(
        ForecastModel.fromJson(
          json,
          cityName: 'London',
          timeZoneOffset: Duration.zero,
          sunrise: sunrise,
          sunset: sunset,
        ),
        ForecastModel(
          Weather(
            temperature: 5.29,
            windSpeed: 1.37 * 3.6,
            timeZoneOffset: Duration.zero,
            tempFeel: 1.94,
            condition: 802,
            minTemperature: 5.29,
            maxTemperature: 6.05,
            cityName: 'London',
            description: 'scattered clouds',
            date: date_time_utils.fromUtcUnixTime(1615118400),
            sunrise: sunrise,
            sunset: sunset,
            humidity: 55,
            iconCode: '03d',
          ),
        ),
      );
    });
  });
}

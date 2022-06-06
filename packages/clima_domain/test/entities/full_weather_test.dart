/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/daily_forecast.dart';
import 'package:clima_domain/entities/full_weather.dart';
import 'package:clima_domain/entities/hourly_forecast.dart';
import 'package:clima_domain/entities/unit_system.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:test/test.dart';

void main() {
  group('FullWeather', () {
    group('changeUnitSystem', () {
      const city = City(name: 'Philadelphia');

      final currentDateTime = DateTime.now();

      // I know the values are nonsense, just ignore it.

      // TODO: figure out how to better explain this.
      // Why is this a function? Well, because floating-point error.
      // Specifically in this case, if you convert the wind speed from km/h to
      // mph and then back to km/h, you won't necessarily get the same value.
      // See the usages of this function below.
      FullWeather getMetricWeather({required double windSpeed}) => FullWeather(
            unitSystem: UnitSystem.metric,
            city: city,
            timeZoneOffset: Duration.zero,
            currentWeather: Weather(
              unitSystem: UnitSystem.metric,
              date: currentDateTime,
              clouds: 30,
              condition: 800,
              description: 'Cloudy',
              humidity: 45,
              iconCode: '01n',
              pressure: 1013,
              tempFeel: 30,
              temperature: 32,
              uvIndex: 0.5,
              windSpeed: windSpeed,
            ),
            dailyForecasts: [
              DailyForecast(
                unitSystem: UnitSystem.metric,
                date: currentDateTime.add(const Duration(days: 1)),
                iconCode: '10d',
                minTemperature: 25,
                maxTemperature: 34,
                pop: 0.42,
                sunrise: currentDateTime.add(const Duration(hours: 24 - 8)),
                sunset: currentDateTime.add(const Duration(hours: 24 + 8)),
              ),
            ],
            hourlyForecasts: [
              HourlyForecast(
                unitSystem: UnitSystem.metric,
                date: currentDateTime.add(const Duration(hours: 2)),
                iconCode: '04n',
                pop: 0.1,
                temperature: 26,
              ),
            ],
          );

      // TODO: re-write this to use `copyWith` when we have that (e.g. when/if
      // we start using Freezed).

      final imperialWeather = FullWeather(
        unitSystem: UnitSystem.imperial,
        city: city,
        timeZoneOffset: Duration.zero,
        currentWeather: Weather(
          unitSystem: UnitSystem.imperial,
          date: currentDateTime,
          clouds: 30,
          condition: 800,
          description: 'Cloudy',
          humidity: 45,
          iconCode: '01n',
          pressure: 1013,
          tempFeel: 86,
          temperature: 89.6,
          uvIndex: 0.5,
          windSpeed: 0.621371,
        ),
        dailyForecasts: [
          DailyForecast(
            unitSystem: UnitSystem.imperial,
            date: currentDateTime.add(const Duration(days: 1)),
            iconCode: '10d',
            minTemperature: 77,
            maxTemperature: 93.2,
            pop: 0.42,
            sunrise: currentDateTime.add(const Duration(hours: 24 - 8)),
            sunset: currentDateTime.add(const Duration(hours: 24 + 8)),
          ),
        ],
        hourlyForecasts: [
          HourlyForecast(
            unitSystem: UnitSystem.imperial,
            date: currentDateTime.add(const Duration(hours: 2)),
            iconCode: '04n',
            pop: 0.1,
            temperature: 78.8,
          ),
        ],
      );

      test('from metric to imperial', () {
        expect(
          getMetricWeather(windSpeed: 1).changeUnitSystem(UnitSystem.imperial),
          imperialWeather,
        );
      });

      test('from imperial to metric', () {
        expect(
          imperialWeather.changeUnitSystem(UnitSystem.metric),
          // Theoretically the wind speed should be 1, but floating-point
          // inaccuracies. :/
          // See the comment above`getMetricWeather`.
          getMetricWeather(windSpeed: 0.9999996906240001),
        );
      });

      test('from metric to metric', () {
        expect(
          getMetricWeather(windSpeed: 1).changeUnitSystem(UnitSystem.metric),
          getMetricWeather(windSpeed: 1),
        );
      });

      test('from imperial to imperial', () {
        expect(
          imperialWeather.changeUnitSystem(UnitSystem.imperial),
          imperialWeather,
        );
      });
    });
  });
}

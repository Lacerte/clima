/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:math';

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/domain/entities/full_weather.dart';
import 'package:riverpod/riverpod.dart';

class FullWeatherMemoizedDataSource {
  FullWeather? _fullWeather;

  DateTime? _fetchingTime;

  static const _invalidationDuration = Duration(minutes: 10);

  Future<Either<Failure, FullWeather?>> getMemoizedFullWeather() async {
    if (_fullWeather == null) return const Right(null);

    if (DateTime.now().difference(_fetchingTime!) >= _invalidationDuration) {
      _fullWeather = null;
      _fetchingTime = null;
      return const Right(null);
    }

    // Minor delay so that users won't think the fetching is broken or
    // something.
    await Future<void>.delayed(
      Duration(
        milliseconds: 200 + Random().nextInt(800 - 200),
      ),
    );

    return Right(_fullWeather);
  }

  Future<Either<Failure, void>> setFullWeather(FullWeather fullWeather) async {
    _fetchingTime = DateTime.now();
    _fullWeather = fullWeather;
    return const Right(null);
  }
}

final fullWeatherMemoizedDataSourceProvider =
    Provider((ref) => FullWeatherMemoizedDataSource());

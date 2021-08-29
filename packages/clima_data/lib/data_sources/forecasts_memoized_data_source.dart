/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'dart:math';

import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

class ForecastsMemoizedDataSource {
  Forecasts? _forecasts;

  DateTime? _fetchingTime;

  static const _invalidationDuration = Duration(minutes: 1);

  Future<Either<Failure, Forecasts?>> getMemoizedForecasts() async {
    if (_forecasts == null) return const Right(null);

    if (DateTime.now().difference(_fetchingTime!) >= _invalidationDuration) {
      _forecasts = null;
      _fetchingTime = null;
      return const Right(null);
    }

    // Minor delay so that users won't think the fetching is broken or
    // something.
    await Future.delayed(
      Duration(
        milliseconds: 200 + Random().nextInt(800 - 200),
      ),
    );

    return Right(_forecasts);
  }

  Future<Either<Failure, void>> setForecasts(Forecasts forecasts) async {
    _fetchingTime = DateTime.now();
    _forecasts = forecasts;
    return const Right(null);
  }
}

final forecastsMemoizedDataSourceProvider =
    Provider((ref) => ForecastsMemoizedDataSource());

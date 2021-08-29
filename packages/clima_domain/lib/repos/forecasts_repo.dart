/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class ForecastsRepo {
  Future<Either<Failure, Forecasts>> getForecasts(City city);
}

final forecastsRepoProvider =
    Provider<ForecastsRepo>((ref) => throw UnimplementedError());

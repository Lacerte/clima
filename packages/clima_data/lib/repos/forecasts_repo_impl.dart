/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/forecast_remote_data_source.dart';
import 'package:clima_data/data_sources/forecasts_memoized_data_source.dart';
import 'package:clima_data/providers.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

class ForecastsRepoImpl implements ForecastsRepo {
  final ForecastsRemoteDataSource remoteDataSource;

  final ForecastsMemoizedDataSource memoizedDataSource;

  final Connectivity connectivity;

  ForecastsRepoImpl({
    required this.remoteDataSource,
    required this.memoizedDataSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, Forecasts>> getForecasts(City city) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(NoConnection());
    } else {
      final memoizedForecasts = await memoizedDataSource.getMemoizedForecasts();

      if (memoizedForecasts.isLeft() ||
          memoizedForecasts.all((forecasts) =>
              forecasts != null && forecasts.cityName == city.name)) {
        return memoizedForecasts.map((forecasts) => forecasts!);
      }

      final forecasts = (await remoteDataSource.getForecasts(city))
          .map((model) => model.forecasts);

      await forecasts
          .map<Future<void>>(memoizedDataSource.setForecasts)
          .getOrElse(() async {});

      return forecasts;
    }
  }
}

final forecastsRepoImplProvider = Provider(
  (ref) => ForecastsRepoImpl(
    remoteDataSource: ref.watch(forecastRemoteDataSourceProvider),
    memoizedDataSource: ref.watch(forecastsMemoizedDataSourceProvider),
    connectivity: ref.watch(connectivityProvider),
  ),
);

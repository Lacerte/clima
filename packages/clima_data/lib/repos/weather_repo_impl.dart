/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/weather_memoized_data_source.dart';
import 'package:clima_data/data_sources/weather_remote_data_source.dart';
import 'package:clima_data/providers.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

class WeatherRepoImpl implements WeatherRepo {
  final WeatherRemoteDataSource remoteDataSource;

  final WeatherMemoizedDataSource memoizedDataSource;

  final Connectivity connectivity;

  WeatherRepoImpl({
    required this.remoteDataSource,
    required this.memoizedDataSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, Weather>> getWeather(City city) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return const Left(NoConnection());
    } else {
      final memoizedWeather = await memoizedDataSource.getMemoizedWeather();

      if (memoizedWeather.isLeft() ||
          memoizedWeather.all(
              (weather) => weather != null && weather.cityName == city.name)) {
        return memoizedWeather.map((weather) => weather!);
      }

      final weather = (await remoteDataSource.getWeather(city))
          .map((model) => model.weather);

      await weather
          .map<Future<void>>(memoizedDataSource.setWeather)
          .getOrElse(() async {});

      return weather;
    }
  }
}

final weatherRepoImplProvider = Provider(
  (ref) => WeatherRepoImpl(
    remoteDataSource: ref.watch(weatherRemoteDataSourceProvider),
    memoizedDataSource: ref.watch(weatherMemoizedDataSourceProvider),
    connectivity: ref.watch(connectivityProvider),
  ),
);

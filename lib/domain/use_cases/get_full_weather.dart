/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/core/use_case.dart';
import 'package:clima/domain/entities/city.dart';
import 'package:clima/domain/entities/full_weather.dart';
import 'package:clima/domain/repos/full_weather_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

class GetFullWeather implements UseCase<FullWeather, GetFullWeatherParams> {
  const GetFullWeather(this.repo);

  final FullWeatherRepo repo;

  @override
  Future<Either<Failure, FullWeather>> call(GetFullWeatherParams params) =>
      repo.getFullWeather(params.city);
}

class GetFullWeatherParams extends Equatable {
  const GetFullWeatherParams({required this.city});

  final City city;

  @override
  List<Object?> get props => [city];
}

final getFullWeatherProvider =
    Provider((ref) => GetFullWeather(ref.watch(fullWeatherRepoProvider)));

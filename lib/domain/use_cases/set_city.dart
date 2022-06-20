/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/core/use_case.dart';
import 'package:clima/domain/entities/city.dart';
import 'package:clima/domain/repos/city_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

class SetCity implements UseCase<void, SetCityParams> {
  const SetCity(this.repo);

  final CityRepo repo;

  @override
  Future<Either<Failure, void>> call(SetCityParams params) =>
      repo.setCity(params.city);
}

class SetCityParams extends Equatable {
  const SetCityParams(this.city);

  final City city;

  @override
  List<Object?> get props => [city];
}

final setCityProvider = Provider((ref) => SetCity(ref.watch(cityRepoProvider)));

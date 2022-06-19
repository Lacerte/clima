/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/city_local_data_source.dart';
import 'package:clima_data/data_sources/city_random_data_source.dart';
import 'package:clima_data/models/city_model.dart';
import 'package:clima_data/repos/geocoding_repo.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:riverpod/riverpod.dart';

class CityRepoImpl implements CityRepo {
  final CityLocalDataSource localDataSource;

  final CityRandomDataSource randomDataSource;

  final GeocodingRepo geocodingRepo;

  CityRepoImpl({
    required this.localDataSource,
    required this.randomDataSource,
    required this.geocodingRepo,
  });

  @override
  Future<Either<Failure, City>> getCity() async {
    final cityEither = await localDataSource.getCity();

    if (cityEither is Left) {
      return cityEither as Left<Failure>;
    }

    final cityModel = (cityEither as Right<CityModel?>).value;

    if (cityModel == null) {
      return (await randomDataSource.getCity()).map((model) => model.city);
    }

    return Right(cityModel.city);
  }

  @override
  Future<Either<Failure, void>> setCity(City city) async {
    final coordinates = await geocodingRepo.getCoordinates(city);

    return coordinates.fold(
      (failure) async => Left(failure),
      (coordinates) => localDataSource.setCity(coordinates.city),
    );
  }
}

final cityRepoImplProvider = Provider(
  (ref) => CityRepoImpl(
    localDataSource: ref.watch(cityLocalDataSourceProvider),
    randomDataSource: ref.watch(cityRandomDataSourceProvider),
    geocodingRepo: ref.watch(geocodingRepoProvider),
  ),
);

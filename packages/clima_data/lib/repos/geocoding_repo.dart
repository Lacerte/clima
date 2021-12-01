/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/geocoding_remote_data_source.dart';
import 'package:clima_data/models/geographic_coordinates_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:riverpod/riverpod.dart';

class GeocodingRepo {
  GeocodingRepo(this._geocodingRemoteDataSource);

  final GeocodingRemoteDataSource _geocodingRemoteDataSource;

  Future<Either<Failure, GeographicCoordinatesModel>> getCoordinates(
    City city,
  ) =>
      _geocodingRemoteDataSource.getCoordinates(city);
}

final geocodingRepoProvider = Provider(
  (ref) => GeocodingRepo(ref.watch(geocodingRemoteDataSourceProvider)),
);

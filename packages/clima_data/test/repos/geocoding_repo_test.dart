/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/geocoding_caching_data_source.dart';
import 'package:clima_data/data_sources/geocoding_remote_data_source.dart';
import 'package:clima_data/models/geographic_coordinates_model.dart';
import 'package:clima_data/repos/geocoding_repo.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import 'geocoding_repo_test.mocks.dart';

const _city = City(name: 'Tokyo');

const _fakeCoordinates = GeographicCoordinatesModel(
  // Whatever, just random values.
  city: _city, lat: 25, long: 50,
);

@GenerateMocks([GeocodingCachingDataSource, GeocodingRemoteDataSource])
void main() {
  group('GeocodingRepo', () {
    final mockCachingDataSource = MockGeocodingCachingDataSource();
    final mockRemoteDataSource = MockGeocodingRemoteDataSource();
    late ProviderContainer container;
    late GeocodingRepo repo;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          geocodingCachingDataSourceProvider
              .overrideWithValue(mockCachingDataSource),
          geocodingRemoteDataSourceProvider
              .overrideWithValue(mockRemoteDataSource),
        ],
      );
      repo = container.read(geocodingRepoProvider);
    });

    tearDown(() {
      reset(mockCachingDataSource);
      reset(mockRemoteDataSource);
      container.dispose();
    });

    test('returns cached coordinates if present', () async {
      when(mockCachingDataSource.getCachedCoordinates(_city))
          .thenAnswer((_) async => const Right(_fakeCoordinates));

      expect(
        await repo.getCoordinates(_city),
        const Right<Failure, GeographicCoordinatesModel>(_fakeCoordinates),
      );

      verify(mockCachingDataSource.getCachedCoordinates(_city)).called(1);
    });

    test(
        'fetches coordinates from remote data source if coordinates are not in cache',
        () async {
      when(mockCachingDataSource.getCachedCoordinates(_city))
          .thenAnswer((_) async => const Right(null));

      when(mockCachingDataSource.setCachedCoordinates(_city, any))
          .thenAnswer((_) async => const Right(null));

      when(mockRemoteDataSource.getCoordinates(_city))
          .thenAnswer((_) async => const Right(_fakeCoordinates));

      expect(
        await repo.getCoordinates(_city),
        const Right<Failure, GeographicCoordinatesModel>(_fakeCoordinates),
      );

      verify(mockCachingDataSource.getCachedCoordinates(_city)).called(1);
      verify(mockRemoteDataSource.getCoordinates(_city)).called(1);
      verify(
        mockCachingDataSource.setCachedCoordinates(_city, _fakeCoordinates),
      ).called(1);
    });
  });
}

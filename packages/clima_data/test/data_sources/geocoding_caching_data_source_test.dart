/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_data/data_sources/geocoding_caching_data_source.dart';
import 'package:clima_data/models/geographic_coordinates_model.dart';
import 'package:clima_data/providers.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'geocoding_caching_data_source_test.mocks.dart';

const _city = City(name: 'Hamburg');

const _fakeCoordinates = GeographicCoordinatesModel(
  // Whatever, just random values.
  city: _city, lat: 30.2, long: 67,
);

@GenerateMocks([SharedPreferences])
void main() {
  group('GeocodingCachingDataSource', () {
    final mockSharedPreferences = MockSharedPreferences();
    late ProviderContainer container;
    late GeocodingCachingDataSource dataSource;
    late String? cacheString;

    setUp(() {
      cacheString = null;

      when(mockSharedPreferences.containsKey(geocodingCachePrefsKey))
          .thenAnswer((_) => cacheString != null);
      when(mockSharedPreferences.setString(geocodingCachePrefsKey, any))
          .thenAnswer((invocation) async {
        cacheString = invocation.positionalArguments[1] as String;
        return true;
      });

      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
        ],
      );
      dataSource = container.read(geocodingCachingDataSourceProvider);
    });

    tearDown(() {
      reset(mockSharedPreferences);
      container.dispose();
    });

    test('adds item to empty cache correctly', () async {
      expect(
        await dataSource.setCachedCoordinates(_city, _fakeCoordinates),
        const Right<void>(null),
      );

      verify(
        mockSharedPreferences.setString(
          geocodingCachePrefsKey,
          argThat(isNotEmpty),
        ),
      ).called(1);

      expect(
        await dataSource.getCachedCoordinates(_city),
        const Right<GeographicCoordinatesModel?>(_fakeCoordinates),
      );
    });

    test('adds item to non-empty cache correctly', () async {
      // Just pre-filling the cache.
      expect(
        await dataSource.setCachedCoordinates(_city, _fakeCoordinates),
        const Right<void>(null),
      );

      verify(
        mockSharedPreferences.setString(
          geocodingCachePrefsKey,
          argThat(isNotEmpty),
        ),
      ).called(1);

      const otherCity = City(name: 'Kuala Lumpur');

      const otherFakeCoordinates = GeographicCoordinatesModel(
        city: otherCity,
        long: 43.3,
        lat: 85.32,
      );

      final oldCacheString = cacheString;

      expect(
        await dataSource.setCachedCoordinates(otherCity, otherFakeCoordinates),
        const Right<void>(null),
      );

      verify(
        mockSharedPreferences.setString(
          geocodingCachePrefsKey,
          // TODO(mhmdanas): using golden tests here might perhaps be a good idea.
          argThat(isNot(oldCacheString)),
        ),
      ).called(1);

      expect(
        await dataSource.getCachedCoordinates(otherCity),
        const Right<GeographicCoordinatesModel?>(otherFakeCoordinates),
      );
    });

    test('Removes item if its age exceeds invalidation age', () async {
      expect(
        await dataSource.setCachedCoordinates(_city, _fakeCoordinates),
        const Right<void>(null),
      );

      verify(
        mockSharedPreferences.setString(
          geocodingCachePrefsKey,
          argThat(isNotEmpty),
        ),
      ).called(1);

      expect(
        await dataSource.getCachedCoordinates(
          _city,
          // The duration itself is not important; it should just be long enough that
          // we won't hit it in testing.
          invalidationDuration: const Duration(days: 10),
        ),
        const Right<GeographicCoordinatesModel?>(_fakeCoordinates),
      );

      verifyNever(
        mockSharedPreferences.setString(geocodingCachePrefsKey, any),
      );

      const delay = Duration(milliseconds: 500);

      await Future<void>.delayed(delay);

      final oldCacheString = cacheString;

      expect(
        await dataSource.getCachedCoordinates(
          _city,
          invalidationDuration: delay,
        ),
        const Right<GeographicCoordinatesModel?>(null),
      );

      verify(
        mockSharedPreferences.setString(
          geocodingCachePrefsKey,
          argThat(isNot(oldCacheString)),
        ),
      ).called(1);
    });
  });
}

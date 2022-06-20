/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:convert';

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/data/models/geographic_coordinates_model.dart';
import 'package:clima/data/providers.dart';
import 'package:clima/domain/entities/city.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

@visibleForTesting
const geocodingCachePrefsKey = 'geocodingCache';

class _Cache {
  // ignore: prefer_const_constructors_in_immutables
  _Cache(this.map);

  factory _Cache.fromJson(Map<String, dynamic> json) => _Cache(
        json.map(
          (cityName, cacheItemJson) => MapEntry(
            City(name: cityName),
            _CacheItem.fromJson(cacheItemJson as Map<String, dynamic>),
          ),
        ),
      );

  final Map<City, _CacheItem> map;

  Map<String, dynamic> toJson() =>
      map.map((city, cacheItem) => MapEntry(city.name, cacheItem.toJson()));
}

class _CacheItem extends Equatable {
  const _CacheItem({required this.date, required this.coordinates});

  factory _CacheItem.fromJson(Map<String, dynamic> json) => _CacheItem(
        date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
        coordinates: GeographicCoordinatesModel.fromLocalJson(
          json['coordinates'] as Map<String, dynamic>,
        ),
      );

  final DateTime date;

  final GeographicCoordinatesModel coordinates;

  dynamic toJson() => {
        'date': date.millisecondsSinceEpoch,
        'coordinates': coordinates.toJson(),
      };

  @override
  List<Object?> get props => [date, coordinates];
}

class GeocodingCachingDataSource {
  GeocodingCachingDataSource._(this._prefs)
      : _cache = _prefs.containsKey(geocodingCachePrefsKey)
            ? _Cache.fromJson(
                // Defensive copying, in case we're not supposed to modify the map
                // returned by `jsonDecode`.
                Map.of(
                  jsonDecode(_prefs.getString(geocodingCachePrefsKey)!)
                      as Map<String, dynamic>,
                ),
              )
            // The map is not const because we need to modify it.
            // ignore: prefer_const_literals_to_create_immutables
            : _Cache({});

  final SharedPreferences _prefs;

  final _Cache _cache;

  Future<void> _flushCache() =>
      _prefs.setString(geocodingCachePrefsKey, jsonEncode(_cache.toJson()));

  Future<Either<Failure, GeographicCoordinatesModel?>> getCachedCoordinates(
    City city, {
    @visibleForTesting Duration invalidationDuration = const Duration(days: 7),
  }) async {
    if (!_cache.map.containsKey(city)) {
      return const Right(null);
    }

    final item = _cache.map[city]!;

    if (DateTime.now().toUtc().difference(item.date) >= invalidationDuration) {
      _cache.map.remove(city);
      await _flushCache();
      return const Right(null);
    }

    return Right(item.coordinates);
  }

  Future<Either<Failure, void>> setCachedCoordinates(
    City city,
    GeographicCoordinatesModel coordinates,
  ) async {
    // We assign the same coordinates to `coordinates.city` and `city` like
    // this because the city entered by the user might be e.g. "london" instead
    // of "London", so if we only assigned `coordinates.city` we'll get a cache
    // cache.
    _cache.map[coordinates.city] = _cache.map[city] =
        _CacheItem(date: DateTime.now().toUtc(), coordinates: coordinates);
    await _flushCache();
    return const Right(null);
  }
}

final geocodingCachingDataSourceProvider = Provider(
  (ref) => GeocodingCachingDataSource._(ref.watch(sharedPreferencesProvider)),
);

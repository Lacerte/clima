/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:convert';

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/models/geographic_coordinates_model.dart';
import 'package:clima_data/providers.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKey = 'geocodingCache';

class _Cache extends Equatable {
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

  @override
  List<Object?> get props => [map];
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
  GeocodingCachingDataSource(this._prefs)
      : _cache = _prefs.containsKey(_prefsKey)
            ? _Cache.fromJson(
                // Defensive copying, in case we're not supposed to modify the map
                // returned by `jsonDecode`.
                Map.of(
                  jsonDecode(_prefs.getString(_prefsKey)!)
                      as Map<String, dynamic>,
                ),
              )
            // This is not const because we need to modify the map.
            // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
            : _Cache({});

  final SharedPreferences _prefs;

  final _Cache _cache;

  static const _invalidationDuration = Duration(days: 7);

  Future<void> _flushCache() async {
    print("Flushing ${_cache.map} to disk...");
    await _prefs.setString(_prefsKey, jsonEncode(_cache.toJson()));
  }

  Future<Either<Failure, GeographicCoordinatesModel?>> getCachedCoordinates(
    City city,
  ) async {
    if (!_cache.map.containsKey(city)) {
      print('Cache miss for $city');
      return const Right(null);
    }

    print('Found coordinates of $city in cache');

    final item = _cache.map[city]!;

    if (DateTime.now().difference(item.date) >= _invalidationDuration) {
      print('Cache item of $city is too old, removing from cache...');
      _cache.map.remove(item);
      await _flushCache();
      return const Right(null);
    }

    print('Returning cached coordinates of $city');

    return Right(item.coordinates);
  }

  Future<Either<Failure, void>> setCachedGeographicCoordinates(
    City city,
    GeographicCoordinatesModel coordinates,
  ) async {
    print("Setting cached coordinates of $city to $coordinates");
    // We assign the same coordinates to `coordinates.city` and `city` like
    // this because the city entered by the user might be e.g. "london" instead
    // of "London", so if we only assigned `coordinates.city` we'll get a cache
    // cache.
    _cache.map[coordinates.city] = _cache.map[city] =
        _CacheItem(date: DateTime.now(), coordinates: coordinates);
    await _flushCache();
    return const Right(null);
  }
}

final geocodingCachingDataSourceProvider = Provider(
  (ref) => GeocodingCachingDataSource(ref.watch(sharedPreferencesProvider)),
);

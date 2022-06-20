/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:math';

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/data/models/city_model.dart';
import 'package:clima/domain/entities/city.dart';
import 'package:riverpod/riverpod.dart';

const _randomCityNames = [
  'Amsterdam',
  'London',
  'Paris',
  'New York',
  'Las Vegas',
  'Texas',
  'Ohio',
  'Riyadh',
  'Dubai',
  'Istanbul',
  'Berlin',
  'Tokyo',
  'Doha',
  'Venice',
  'Sydney',
];

class CityRandomDataSource {
  Future<Either<Failure, CityModel>> getCity() async => Right(
        CityModel(
          City(
            name: _randomCityNames[Random().nextInt(_randomCityNames.length)],
          ),
        ),
      );
}

final cityRandomDataSourceProvider = Provider((ref) => CityRandomDataSource());

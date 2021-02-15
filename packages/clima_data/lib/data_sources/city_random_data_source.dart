import 'dart:math';

import 'package:clima_core/failure.dart';
import 'package:clima_data/models/city_model.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class CityRandomDataSource {
  Future<Either<Failure, CityModel>> getCity();
}

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

class CityRandomDataSourceImpl implements CityRandomDataSource {
  @override
  Future<Either<Failure, CityModel>> getCity() async => Right(
        CityModel(
          name: _randomCityNames[Random().nextInt(_randomCityNames.length)],
        ),
      );
}

final cityRandomDataSourceProvider =
    Provider<CityRandomDataSource>((ref) => CityRandomDataSourceImpl());

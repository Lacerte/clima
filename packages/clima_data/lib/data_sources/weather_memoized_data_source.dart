import 'dart:math';

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:riverpod/riverpod.dart';

class WeatherMemoizedDataSource {
  Weather? _weather;

  DateTime? _fetchingTime;

  static const _invalidationDuration = Duration(minutes: 1);

  Future<Either<Failure, Weather?>> getMemoizedWeather() async {
    if (_weather == null) return const Right(null);

    if (DateTime.now().difference(_fetchingTime!) >= _invalidationDuration) {
      _weather = null;
      _fetchingTime = null;
      return const Right(null);
    }

    // Minor delay so that users won't think the fetching is broken or
    // something.
    await Future.delayed(
      Duration(
        milliseconds: 200 + Random().nextInt(800 - 200),
      ),
    );

    return Right(_weather);
  }

  Future<Either<Failure, void>> setWeather(Weather weather) async {
    _fetchingTime = DateTime.now();
    _weather = weather;
    return const Right(null);
  }
}

final weatherMemoizedDataSourceProvider =
    Provider((ref) => WeatherMemoizedDataSource());

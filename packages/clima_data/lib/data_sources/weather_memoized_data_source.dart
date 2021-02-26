import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class WeatherMemoizedDataSource {
  Future<Either<Failure, void>> setWeather(Weather weather);

  Future<Either<Failure, Weather>> getMemoizedWeather();
}

class WeatherMemoizedDataSourceImpl implements WeatherMemoizedDataSource {
  Weather _weather;

  DateTime _fetchingTime;

  static const _invalidationDuration = Duration(minutes: 1);

  @override
  Future<Either<Failure, Weather>> getMemoizedWeather() async {
    if (_weather == null) return Right(null);

    if (DateTime.now().difference(_fetchingTime) >= _invalidationDuration) {
      _weather = null;
      _fetchingTime = null;
      return Right(null);
    }

    return Right(_weather);
  }

  @override
  Future<Either<Failure, void>> setWeather(Weather weather) async {
    _fetchingTime = DateTime.now();
    _weather = weather;
    return Right(null);
  }
}

final weatherMemoizedDataSourceProvider = Provider<WeatherMemoizedDataSource>(
  (ref) => WeatherMemoizedDataSourceImpl(),
);

import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecast.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class ForecastRepo {
  Future<Either<Failure, Forecast>> getWeather(City city);
}

final forecastRepoProvider =
    Provider<ForecastRepo>((ref) => throw UnimplementedError());

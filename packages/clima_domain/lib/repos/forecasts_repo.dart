import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class ForecastsRepo {
  Future<Either<Failure, Forecasts>> getForecasts(ApiKey city);
}

final forecastsRepoProvider =
    Provider<ForecastsRepo>((ref) => throw UnimplementedError());

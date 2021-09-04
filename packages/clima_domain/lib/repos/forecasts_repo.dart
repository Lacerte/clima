import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:riverpod/riverpod.dart';

abstract class ForecastsRepo {
  Future<Either<Failure, Forecasts>> getForecasts(City city);
}

final forecastsRepoProvider =
    Provider<ForecastsRepo>((ref) => throw UnimplementedError());

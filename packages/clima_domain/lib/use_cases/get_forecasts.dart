import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

class GetForecasts implements UseCase<Forecasts, GetForecastsParams> {
  final ForecastsRepo repo;

  const GetForecasts(this.repo);

  @override
  Future<Either<Failure, Forecasts>> call(GetForecastsParams params) =>
      repo.getForecasts(params.city);
}

class GetForecastsParams extends Equatable {
  const GetForecastsParams({required this.city});

  final City city;

  @override
  List<Object?> get props => [city];
}

final getForecastsProvider =
    Provider((ref) => GetForecasts(ref.watch(forecastsRepoProvider)));

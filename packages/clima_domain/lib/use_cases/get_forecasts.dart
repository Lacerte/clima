import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class GetWeather implements UseCase<Forecasts, GetWeatherParams> {
  final ForecastsRepo repo;

  const GetWeather(this.repo);

  @override
  Future<Either<Failure, Forecasts>> call(GetWeatherParams params) =>
      repo.getForecasts(params.city);
}

class GetWeatherParams extends Equatable {
  const GetWeatherParams({@required this.city});

  final City city;

  @override
  List<Object> get props => [city];
}

final getWeatherProvider =
    Provider((ref) => GetWeather(ref.watch(forecastsRepoProvider)));

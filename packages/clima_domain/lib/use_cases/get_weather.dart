import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:equatable/equatable.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

class GetWeather implements UseCase<Weather, GetWeatherParams> {
  final WeatherRepo repo;

  const GetWeather(this.repo);

  @override
  Future<Either<Failure, Weather>> call(GetWeatherParams params) =>
      repo.getWeather(params.city);
}

class GetWeatherParams extends Equatable {
  const GetWeatherParams({required this.city});

  final City city;

  @override
  List<Object?> get props => [city];
}

final getWeatherProvider =
    Provider((ref) => GetWeather(ref.watch(weatherRepoProvider)));

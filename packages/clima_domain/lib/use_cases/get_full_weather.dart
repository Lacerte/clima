import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/full_weather.dart';
import 'package:clima_domain/repos/full_weather_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

class GetFullWeather implements UseCase<FullWeather, GetFullWeatherParams> {
  final FullWeatherRepo repo;

  const GetFullWeather(this.repo);

  @override
  Future<Either<Failure, FullWeather>> call(GetFullWeatherParams params) =>
      repo.getFullWeather(params.city);
}

class GetFullWeatherParams extends Equatable {
  const GetFullWeatherParams({required this.city});

  final City city;

  @override
  List<Object?> get props => [city];
}

final getFullWeatherProvider =
    Provider((ref) => GetFullWeather(ref.watch(fullWeatherRepoProvider)));

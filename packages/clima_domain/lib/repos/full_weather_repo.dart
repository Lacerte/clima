import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/full_weather.dart';
import 'package:riverpod/riverpod.dart';

abstract class FullWeatherRepo {
  Future<Either<Failure, FullWeather>> getFullWeather(City city);
}

final fullWeatherRepoProvider =
    Provider<FullWeatherRepo>((ref) => throw UnimplementedError());

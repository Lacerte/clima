import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:riverpod/riverpod.dart';

abstract class WeatherRepo {
  Future<Either<Failure, Weather>> getWeather(City city);
}

final weatherRepoProvider =
    Provider<WeatherRepo>((ref) => throw UnimplementedError());

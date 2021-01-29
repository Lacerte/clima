import 'dart:convert';

import 'package:clima_core/failure.dart';
import 'package:clima_data/models/weather_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

const String apiKey = '4bef3adf2fcb90307c2bf5feac75a2ba';

const String openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather';

abstract class WeatherRemoteDataSource {
  Future<Either<Failure, WeatherModel>> getWeather(City city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<Either<Failure, WeatherModel>> getWeather(City city) async {
    // TODO: create a client as the docs recommend creating a client when
    // making multiple requests to the same server.
    final response = await http.get(
      '$openWeatherMapURL?q=${city.name}&appid=$apiKey&units=metric',
    );

    if (response.statusCode >= 200 && response.statusCode <= 226) {
      return Right(WeatherModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(FailedToParseResponse());
    }
  }
}

final weatherRemoteDataSourceProvider =
    Provider<WeatherRemoteDataSource>((ref) => WeatherRemoteDataSourceImpl());

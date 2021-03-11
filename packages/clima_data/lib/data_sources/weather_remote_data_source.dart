import 'dart:convert';

import 'package:clima_core/failure.dart';
import 'package:clima_data/constants.dart';
import 'package:clima_data/models/weather_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

abstract class WeatherRemoteDataSource {
  Future<Either<Failure, WeatherModel>> getWeather(City city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<Either<Failure, WeatherModel>> getWeather(City city) async {
    // TODO: create a client as the docs recommend creating a client when
    // making multiple requests to the same server.
    final response = await http.get(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {
          'q': city.name,
          'appid': apiKey,
          'units': 'metric',
        },
      ),
    );

    if (response.statusCode >= 200 && response.statusCode <= 226) {
      try {
        return Right(WeatherModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
      } on FormatException {
        return const Left(FailedToParseResponse());
      }
    } else if (response.statusCode == 503) {
      return const Left(ServerDown());
    } else if (response.statusCode == 404) {
      return Left(InvalidCityName(city.name));
    } else {
      // TODO: I don't think this failure is fit for this situation.
      return const Left(FailedToParseResponse());
    }
  }
}

final weatherRemoteDataSourceProvider =
    Provider<WeatherRemoteDataSource>((ref) => WeatherRemoteDataSourceImpl());

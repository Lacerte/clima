import 'dart:convert';

import 'package:clima_core/failure.dart';
import 'package:clima_data/models/forcasts_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

const String apiKey = '4bef3adf2fcb90307c2bf5feac75a2ba';

abstract class ForecastsRemoteDataSource {
  Future<Either<Failure, ForecastsModel>> getWeather(City city);
}

class ForecastsRemoteDataSourceImpl implements ForecastsRemoteDataSource {
  @override
  Future<Either<Failure, ForecastsModel>> getWeather(City city) async {
    // TODO: create a client as the docs recommend creating a client when
    // making multiple requests to the same server.
    final response = await http.get(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/forecast',
        queryParameters: {
          'q': city.name,
          'appid': apiKey,
          'units': 'metric',
        },
      ),
    );
    if (response.statusCode >= 200 && response.statusCode <= 226) {
      try {
        return Right(ForecastsModel.fromJson(jsonDecode(response.body)));
      } on FormatException {
        return Left(FailedToParseResponse());
      }
    } else if (response.statusCode == 503) {
      return Left(ServerDown());
    } else if (response.statusCode == 404) {
      return Left(InvalidCityName(city.name));
    } else {
      // TODO: I don't think this failure is fit for this situation.
      return Left(FailedToParseResponse());
    }
  }
}

final forecastRemoteDataSourceProvider = Provider<ForecastsRemoteDataSource>(
    (ref) => ForecastsRemoteDataSourceImpl());

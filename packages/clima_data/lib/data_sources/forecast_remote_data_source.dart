import 'dart:convert';

import 'package:clima_core/failure.dart';
import 'package:clima_data/models/forecasts_model.dart';
import 'package:clima_data/repos/api_key_repo.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

abstract class ForecastsRemoteDataSource {
  Future<Either<Failure, ForecastsModel>> getForecasts(City city);
}

class ForecastsRemoteDataSourceImpl implements ForecastsRemoteDataSource {
  ForecastsRemoteDataSourceImpl(this.apiKeyRepo);

  final ApiKeyRepo apiKeyRepo;

  @override
  Future<Either<Failure, ForecastsModel>> getForecasts(City city) async {
    final apiKey = (await apiKeyRepo.getApiKey()).fold((_) => null, id)!;

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
        return Right(ForecastsModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>));
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

final forecastRemoteDataSourceProvider = Provider<ForecastsRemoteDataSource>(
    (ref) => ForecastsRemoteDataSourceImpl(ref.watch(apiKeyRepoProvider)));

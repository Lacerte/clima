import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/api_key_local_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

const _defaultApiKey = '0cca00b6155fcac417cc140a5deba9a4';

class ApiKeyRepo {
  ApiKeyRepo(this.localDataSource);

  final ApiKeyLocalDataSource localDataSource;

  Future<Either<Failure, String>> getApiKey() async =>
      (await localDataSource.getApiKey()).map((key) => key ?? _defaultApiKey);

  Future<Either<Failure, void>> setApiKey(String apiKey) async {
    final response = await http.get(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {'appid': apiKey},
      ),
    );

    switch (response.statusCode) {
      case 400:
        return localDataSource.setApiKey(apiKey);

      case 404:
        return const Left(InvalidApiKey());

      case 503:
        return const Left(ServerDown());

      default:
        return const Left(FailedToParseResponse());
    }
  }
}

final apiKeyRepoProvider =
    Provider((ref) => ApiKeyRepo(ref.watch(apiKeyLocalDataSourceProvider)));

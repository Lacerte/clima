/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/api_key_local_data_source.dart';
import 'package:clima_data/models/api_key_model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class ApiKeyRepo {
  ApiKeyRepo(this.localDataSource);

  final ApiKeyLocalDataSource localDataSource;

  Future<Either<Failure, ApiKeyModel>> getApiKey() =>
      localDataSource.getApiKey();

  Future<Either<Failure, void>> setApiKey(ApiKeyModel apiKeyModel) async {
    if (!apiKeyModel.isCustom) {
      return localDataSource.setApiKey(apiKeyModel);
    }

    final response = await http.get(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {'appid': apiKeyModel.apiKey},
      ),
    );

    switch (response.statusCode) {
      case 400:
        return localDataSource.setApiKey(apiKeyModel);

      case 401:
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

/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:convert';

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/functions.dart';
import 'package:clima_data/models/geographic_coordinates_model.dart';
import 'package:clima_data/repos/api_key_repo.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class GeocodingRemoteDataSource {
  GeocodingRemoteDataSource(this._apiKeyRepo);

  final ApiKeyRepo _apiKeyRepo;

  Future<Either<Failure, GeographicCoordinatesModel>> getCoordinates(
    City city,
  ) async {
    final apiKey = (await _apiKeyRepo.getApiKey()).fold((_) => null, id)!;

    final response = await http.get(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/geo/1.0/direct',
        queryParameters: {
          'q': city.name,
          'appid': apiKey,
          'limit': '1',
        },
      ),
    );

    if (response.statusCode == 503) {
      return const Left(ServerDown());
    }

    dynamic body;

    try {
      body = jsonDecode(response.body);
    } on FormatException {
      return const Left(FailedToParseResponse());
    }

    if (body is List) {
      if (body.isEmpty) {
        return Left(InvalidCityName(city.name));
      }

      return Right(GeographicCoordinatesModel.fromRemoteJson(body));
    } else {
      // TODO: I don't think this failure is fit for this situation.
      return const Left(FailedToParseResponse());
    }
  }
}

final geocodingRemoteDataSourceProvider =
    Provider((ref) => GeocodingRemoteDataSource(ref.watch(apiKeyRepoProvider)));

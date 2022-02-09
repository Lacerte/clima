/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:convert';

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/functions.dart';
import 'package:clima_data/models/full_weather_model.dart';
import 'package:clima_data/repos/api_key_repo.dart';
import 'package:clima_data/repos/geocoding_repo.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class FullWeatherRemoteDataSource {
  FullWeatherRemoteDataSource(this._apiKeyRepo, this._geocodingRepo);

  final ApiKeyRepo _apiKeyRepo;

  final GeocodingRepo _geocodingRepo;

  Future<Either<Failure, FullWeatherModel>> getFullWeather(City city) async {
    final apiKeyModel = (await _apiKeyRepo.getApiKey()).fold((_) => null, id)!;

    final coordinates =
        (await _geocodingRepo.getCoordinates(city)).fold((_) => null, id)!;

    // TODO: create a client as the docs recommend creating a client when
    // making multiple requests to the same server.
    final response = await http.get(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/onecall',
        queryParameters: {
          'lon': coordinates.long.toString(),
          'lat': coordinates.lat.toString(),
          'appid': apiKeyModel.apiKey,
          'units': 'metric',
          'exclude': 'minutely,alerts',
        },
      ),
    );

    if (response.statusCode >= 200 && response.statusCode <= 226) {
      try {
        return Right(
          FullWeatherModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>,
            city: city,
          ),
        );
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

final fullWeatherRemoteDataSourceProvider = Provider(
  (ref) => FullWeatherRemoteDataSource(
    ref.watch(apiKeyRepoProvider),
    ref.watch(geocodingRepoProvider),
  ),
);

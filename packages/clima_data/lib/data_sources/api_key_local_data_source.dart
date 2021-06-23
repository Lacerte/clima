import 'package:clima_core/failure.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

const _apiKeyPrefsKey = 'openWeatherMapApiKey';

class ApiKeyLocalDataSource {
  Future<Either<Failure, String?>> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();

    return Right(prefs.getString(_apiKeyPrefsKey));
  }

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
        final prefs = await SharedPreferences.getInstance();

        prefs.setString(_apiKeyPrefsKey, apiKey);

        return const Right(null);

      case 404:
        return const Left(InvalidApiKey());

      case 503:
        return const Left(ServerDown());

      default:
        return const Left(FailedToParseResponse());
    }
  }
}

final apiKeyLocalDataSourceProvider =
    Provider((ref) => ApiKeyLocalDataSource());

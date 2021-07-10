import 'package:clima_core/failure.dart';
import 'package:clima_data/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _apiKeyPrefsKey = 'openWeatherMapApiKey';

class ApiKeyLocalDataSource {
  ApiKeyLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  Future<Either<Failure, String?>> getApiKey() async =>
      Right(_prefs.getString(_apiKeyPrefsKey));

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
        _prefs.setString(_apiKeyPrefsKey, apiKey);

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

final apiKeyLocalDataSourceProvider = Provider(
    (ref) => ApiKeyLocalDataSource(ref.watch(sharedPreferencesProvider)));

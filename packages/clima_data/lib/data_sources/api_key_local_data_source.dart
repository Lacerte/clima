import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _apiKeyPrefsKey = 'openWeatherMapApiKey';

class ApiKeyLocalDataSource {
  ApiKeyLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  Future<Either<Failure, String?>> getApiKey() async =>
      Right(_prefs.getString(_apiKeyPrefsKey));

  Future<Either<Failure, void>> setApiKey(String? apiKey) async {
    if (apiKey == null) {
      await _prefs.remove(_apiKeyPrefsKey);
    } else {
      await _prefs.setString(_apiKeyPrefsKey, apiKey);
    }
    return const Right(null);
  }
}

final apiKeyLocalDataSourceProvider = Provider(
  (ref) => ApiKeyLocalDataSource(ref.watch(sharedPreferencesProvider)),
);

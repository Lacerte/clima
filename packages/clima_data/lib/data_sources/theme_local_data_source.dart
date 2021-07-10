import 'package:clima_core/failure.dart';
import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_data/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'app_theme';

const String _darkThemeKey = 'app_dark_theme';

abstract class ThemeLocalDataSource {
  Future<Either<Failure, ThemeModel?>> getTheme();

  Future<Either<Failure, void>> setTheme(ThemeModel theme);

  Future<Either<Failure, DarkThemeModel?>> getDarkTheme();

  Future<Either<Failure, void>> setDarkTheme(DarkThemeModel theme);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  ThemeLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<Either<Failure, ThemeModel?>> getTheme() async {
    final string = _prefs.getString(_themeKey);

    if (string == null) {
      return const Right(null);
    }

    // TODO: create a proper failure.
    return Right(ThemeModel.parse(string));
  }

  @override
  Future<Either<Failure, void>> setTheme(ThemeModel theme) async {
    await _prefs.setString(_themeKey, theme.toString());

    return const Right(null);
  }

  @override
  Future<Either<Failure, DarkThemeModel?>> getDarkTheme() async {
    final string = _prefs.getString(_darkThemeKey);

    if (string == null) {
      return const Right(null);
    }

    // TODO: create a proper failure.
    return Right(DarkThemeModel.parse(string));
  }

  @override
  Future<Either<Failure, void>> setDarkTheme(DarkThemeModel theme) async {
    await _prefs.setString(_darkThemeKey, theme.toString());

    return const Right(null);
  }
}

final themeLocalDataSourceProvider = Provider<ThemeLocalDataSource>(
    (ref) => ThemeLocalDataSourceImpl(ref.watch(sharedPreferencesProvider)));

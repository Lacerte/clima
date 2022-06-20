/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/data/models/dark_theme_model.dart';
import 'package:clima/data/models/theme_model.dart';
import 'package:clima/data/providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'app_theme';

const String _darkThemeKey = 'app_dark_theme';

class ThemeLocalDataSource {
  ThemeLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  Future<Either<Failure, ThemeModel?>> getTheme() async {
    final string = _prefs.getString(_themeKey);

    if (string == null) {
      return const Right(null);
    }

    // TODO: create a proper failure.
    return Right(ThemeModel.parse(string));
  }

  Future<Either<Failure, void>> setTheme(ThemeModel theme) async {
    await _prefs.setString(_themeKey, theme.toString());

    return const Right(null);
  }

  Future<Either<Failure, DarkThemeModel?>> getDarkTheme() async {
    final string = _prefs.getString(_darkThemeKey);

    if (string == null) {
      return const Right(null);
    }

    // TODO: create a proper failure.
    return Right(DarkThemeModel.parse(string));
  }

  Future<Either<Failure, void>> setDarkTheme(DarkThemeModel theme) async {
    await _prefs.setString(_darkThemeKey, theme.toString());

    return const Right(null);
  }
}

final themeLocalDataSourceProvider = Provider(
  (ref) => ThemeLocalDataSource(ref.watch(sharedPreferencesProvider)),
);

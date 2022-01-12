/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/models/unit_system_model.dart';
import 'package:clima_data/providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKey = 'unit_system';

class UnitSystemLocalDataSource {
  UnitSystemLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  Future<Either<Failure, UnitSystemModel?>> getUnitSystem() async {
    final string = _prefs.getString(_prefsKey);

    if (string == null) return const Right(null);

    return Right(UnitSystemModel.parse(string));
  }

  Future<Either<Failure, void>> setUnitSystem(UnitSystemModel model) async {
    await _prefs.setString(_prefsKey, model.toString());

    return const Right(null);
  }
}

final unitSystemLocalDataSourceProvider = Provider(
  (ref) => UnitSystemLocalDataSource(ref.watch(sharedPreferencesProvider)),
);

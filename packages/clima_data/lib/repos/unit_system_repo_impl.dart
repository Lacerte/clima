/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/unit_system_local_data_source.dart';
import 'package:clima_data/models/unit_system_model.dart';
import 'package:clima_domain/entities/unit_system.dart';
import 'package:clima_domain/repos/unit_system_repo.dart';
import 'package:riverpod/riverpod.dart';

class UnitSystemRepoImpl implements UnitSystemRepo {
  final UnitSystemLocalDataSource _localDataSource;

  UnitSystemRepoImpl(this._localDataSource);

  @override
  Future<Either<Failure, UnitSystem>> getUnitSystem() async =>
      (await _localDataSource.getUnitSystem())
          .map((model) => model?.unitSystem ?? UnitSystem.metric);

  @override
  Future<Either<Failure, void>> setUnitSystem(UnitSystem unitSystem) =>
      _localDataSource.setUnitSystem(UnitSystemModel(unitSystem));
}

final unitSystemRepoImplProvider = Provider(
  (ref) => UnitSystemRepoImpl(ref.watch(unitSystemLocalDataSourceProvider)),
);

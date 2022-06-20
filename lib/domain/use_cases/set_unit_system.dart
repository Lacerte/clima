/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/core/either.dart';
import 'package:clima/core/failure.dart';
import 'package:clima/core/use_case.dart';
import 'package:clima/domain/entities/unit_system.dart';
import 'package:clima/domain/repos/unit_system_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

class SetUnitSystem implements UseCase<void, SetUnitSystemParams> {
  const SetUnitSystem(this.repo);

  final UnitSystemRepo repo;

  @override
  Future<Either<Failure, void>> call(SetUnitSystemParams params) =>
      repo.setUnitSystem(params.unitSystem);
}

class SetUnitSystemParams extends Equatable {
  const SetUnitSystemParams(this.unitSystem);

  final UnitSystem unitSystem;

  @override
  List<Object?> get props => [unitSystem];
}

final setUnitSystemProvider =
    Provider((ref) => SetUnitSystem(ref.watch(unitSystemRepoProvider)));

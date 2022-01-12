/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/unit_system.dart';
import 'package:clima_domain/repos/unit_system_repo.dart';
import 'package:riverpod/riverpod.dart';

class GetUnitSystem implements UseCase<UnitSystem, NoParams> {
  final UnitSystemRepo repo;

  const GetUnitSystem(this.repo);

  @override
  Future<Either<Failure, UnitSystem>> call(NoParams params) =>
      repo.getUnitSystem();
}

final getUnitSystemProvider =
    Provider((ref) => GetUnitSystem(ref.watch(unitSystemRepoProvider)));

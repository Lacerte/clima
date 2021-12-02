/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'either.dart';
import 'failure.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P params);
}

@sealed
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => const [];
}

/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@sealed
abstract class Failure extends Equatable {
  const Failure();
}

class NoConnection extends Failure {
  const NoConnection();

  @override
  List<Object?> get props => const [];
}

class ServerDown extends Failure {
  const ServerDown();

  @override
  List<Object?> get props => const [];
}

class FailedToParseResponse extends Failure {
  const FailedToParseResponse();

  @override
  List<Object?> get props => const [];
}

class InvalidCityName extends Failure {
  const InvalidCityName(this.cityName);

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}

class InvalidApiKey extends Failure {
  const InvalidApiKey();

  @override
  List<Object?> get props => const [];
}

class CallLimitExceeded extends Failure {
  const CallLimitExceeded();

  @override
  List<Object?> get props => const [];
}

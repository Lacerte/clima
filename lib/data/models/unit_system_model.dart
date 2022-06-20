/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/domain/entities/unit_system.dart';
import 'package:equatable/equatable.dart';

class UnitSystemModel extends Equatable {
  const UnitSystemModel(this.unitSystem);

  factory UnitSystemModel.parse(String string) {
    switch (string) {
      case 'metric':
        return const UnitSystemModel(UnitSystem.metric);

      case 'imperial':
        return const UnitSystemModel(UnitSystem.imperial);

      default:
        throw ArgumentError();
    }
  }

  final UnitSystem unitSystem;

  @override
  String toString() {
    switch (unitSystem) {
      case UnitSystem.metric:
        return 'metric';

      case UnitSystem.imperial:
        return 'imperial';
    }
  }

  @override
  List<Object?> get props => [unitSystem];
}

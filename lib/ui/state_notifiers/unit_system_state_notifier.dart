/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/core/failure.dart';
import 'package:clima/core/use_case.dart';
import 'package:clima/domain/entities/unit_system.dart';
import 'package:clima/domain/use_cases/get_unit_system.dart';
import 'package:clima/domain/use_cases/set_unit_system.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

@sealed
@immutable
abstract class UnitSystemState extends Equatable {
  const UnitSystemState();

  UnitSystem? get unitSystem => null;

  @override
  List<Object?> get props => const [];
}

class Empty extends UnitSystemState {
  const Empty();
}

class Loading extends UnitSystemState {
  const Loading();
}

class Loaded extends UnitSystemState {
  const Loaded(this.unitSystem);

  @override
  final UnitSystem unitSystem;

  @override
  List<Object?> get props => [unitSystem];
}

class Error extends UnitSystemState {
  const Error(this.failure, {this.unitSystem});

  final Failure failure;

  @override
  final UnitSystem? unitSystem;

  @override
  List<Object?> get props => [failure, unitSystem];
}

class UnitSystemStateNotifier extends StateNotifier<UnitSystemState> {
  UnitSystemStateNotifier(this._getUnitSystem, this._setUnitSystem)
      : super(const Empty());

  final GetUnitSystem _getUnitSystem;

  final SetUnitSystem _setUnitSystem;

  Future<void> loadUnitSystem() async {
    state = const Loading();
    final data = await _getUnitSystem(const NoParams());
    state = data.fold(Error.new, Loaded.new);
  }

  Future<void> setUnitSystem(UnitSystem unitSystem) async {
    (await _setUnitSystem(SetUnitSystemParams(unitSystem))).fold((failure) {
      state = Error(failure, unitSystem: state.unitSystem);
    }, (_) {
      state = Loaded(unitSystem);
    });
  }
}

final unitSystemStateNotifierProvider =
    StateNotifierProvider<UnitSystemStateNotifier, UnitSystemState>(
  (ref) => UnitSystemStateNotifier(
    ref.watch(getUnitSystemProvider),
    ref.watch(setUnitSystemProvider),
  ),
);

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_domain/entities/city.dart';
import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  const CityModel(this.city);

  final City city;

  @override
  List<Object?> get props => [city];
}

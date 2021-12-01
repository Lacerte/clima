/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_domain/entities/city.dart';
import 'package:equatable/equatable.dart';

class GeographicCoordinatesModel extends Equatable {
  const GeographicCoordinatesModel({
    required this.city,
    required this.long,
    required this.lat,
  });

  factory GeographicCoordinatesModel.fromJson(List json) =>
      GeographicCoordinatesModel(
        city: City(name: json[0]["name"] as String),
        long: (json[0]["lon"] as num).toDouble(),
        lat: (json[0]["lat"] as num).toDouble(),
      );

  final City city;

  final double long;

  final double lat;

  @override
  List<Object?> get props => [city, long, lat];
}

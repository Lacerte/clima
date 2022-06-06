/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:convert';

import 'package:clima_data/models/geographic_coordinates_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeographicCoordinatesModel', () {
    test('fromLocalJson', () {
      final json = jsonDecode('{"city":"Los Angeles","long":23,"lat":90}')
          as Map<String, dynamic>;

      expect(
        GeographicCoordinatesModel.fromLocalJson(json),
        const GeographicCoordinatesModel(
          city: City(name: 'Los Angeles'),
          long: 23,
          lat: 90,
        ),
      );
    });

    test('fromRemoteJson', () {
      final json = jsonDecode(
        '[{"name":"Riyadh","local_names":{"af":"Riaad","ar":"الرياض","ascii":"Riyadh","az":"Ər-Riyad","bg":"Рияд","ca":"Al-Riyad","da":"Riyadh","de":"Riad","el":"Ριάντ","en":"Riyadh","fa":"ریاض","feature_name":"Riyadh","fi":"Riad","fr":"Riyad","he":"ריאד","hi":"रियाद","hr":"Rijad","hu":"Rijád","id":"Riyadh","it":"Riyad","ja":"リヤド","la":"Riadum","lt":"Rijadas","mk":"Ријад","nl":"Riyad","no":"Riyadh","pl":"Rijad","pt":"Riade","ro":"Riyadh","ru":"Эр-Рияд","sk":"Rijád","sr":"Ријад","th":"ริยาด","tr":"Riyad"},"lat":24.6877,"lon":46.7219,"country":"SA"}]',
      ) as List;

      expect(
        GeographicCoordinatesModel.fromRemoteJson(json),
        const GeographicCoordinatesModel(
          city: City(name: 'Riyadh'),
          long: 46.7219,
          lat: 24.6877,
        ),
      );
    });

    test('toJson', () {
      expect(
        const GeographicCoordinatesModel(
          city: City(name: 'Manchester'),
          long: 35,
          lat: 25.4,
        ).toJson(),
        const <String, dynamic>{'city': 'Manchester', 'long': 35, 'lat': 25.4},
      );
    });
  });
}

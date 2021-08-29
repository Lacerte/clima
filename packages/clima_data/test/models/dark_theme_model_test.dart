/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:clima_data/models/dark_theme_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DarkThemeModel', () {
    group('parse', () {
      test('works for all values', () {
        for (final value in DarkThemeModel.values) {
          expect(value, DarkThemeModel.parse(value.toString()));
        }
      });

      test('fails on invalid strings', () {
        expect(() => DarkThemeModel.parse('foo'), throwsFormatException);
      });
    });
  });
}

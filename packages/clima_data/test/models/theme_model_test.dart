import 'package:clima_data/models/theme_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeModel', () {
    group('parse', () {
      test('works for all values', () {
        for (final value in ThemeModel.values) {
          expect(value, ThemeModel.parse(value.toString()));
        }
      });

      test('fails on invalid strings', () {
        expect(() => ThemeModel.parse('foo'), throwsFormatException);
      });
    });
  });
}

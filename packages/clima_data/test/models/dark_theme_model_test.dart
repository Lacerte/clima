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

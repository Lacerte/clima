import 'package:collection/collection.dart';

class ThemeModel {
  const ThemeModel._(this.string);

  final String string;

  static const light = ThemeModel._('light');

  static const dark = ThemeModel._('dark');

  static const black = ThemeModel._('black');

  static const values = [light, dark, black];

  static ThemeModel parse(String string) {
    final theme = values.firstWhereOrNull((theme) => theme.string == string);

    if (theme == null) {
      throw FormatException('Invalid theme', string);
    }

    return theme;
  }

  @override
  String toString() => string;
}

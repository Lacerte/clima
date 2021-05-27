import 'package:collection/collection.dart';

class DarkThemeModel {
  const DarkThemeModel._(this.string);

  final String string;

  static const darkGrey = DarkThemeModel._('darkGrey');

  static const black = DarkThemeModel._('black');

  static const values = [darkGrey, black];

  static DarkThemeModel parse(String string) {
    final theme = values.firstWhereOrNull((theme) => theme.string == string);

    if (theme == null) {
      throw FormatException('Invalid theme', string);
    }

    return theme;
  }

  @override
  String toString() => string;
}

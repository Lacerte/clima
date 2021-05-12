import 'package:clima_core/failure.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'app_theme';

abstract class ThemeLocalDataSource {
  Future<Either<Failure, ThemeModel?>> getTheme();

  Future<Either<Failure, void>> setTheme(ThemeModel theme);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  @override
  Future<Either<Failure, ThemeModel?>> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final string = prefs.getString(_themeKey);

    if (string == null) {
      return const Right(null);
    }

    // TODO: create a proper failure.
    return Right(ThemeModel.parse(string));
  }

  @override
  Future<Either<Failure, void>> setTheme(ThemeModel theme) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_themeKey, theme.toString());

    return const Right(null);
  }
}

final themeLocalDataSourceProvider =
    Provider<ThemeLocalDataSource>((ref) => ThemeLocalDataSourceImpl());

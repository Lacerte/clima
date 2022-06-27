/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/core/failure.dart';
import 'package:clima/core/functions.dart';
import 'package:clima/data/models/dark_theme_model.dart';
import 'package:clima/data/models/theme_model.dart';
import 'package:clima/data/repos/theme_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

@sealed
@immutable
abstract class ThemeState extends Equatable {
  const ThemeState();

  ThemeModel? get theme;

  DarkThemeModel? get darkTheme;
}

class EmptyState extends ThemeState {
  const EmptyState();

  @override
  ThemeModel? get theme => null;

  @override
  DarkThemeModel? get darkTheme => null;

  @override
  List<Object?> get props => const [];
}

class Loading extends ThemeState {
  const Loading();

  @override
  ThemeModel? get theme => null;

  @override
  DarkThemeModel? get darkTheme => null;

  @override
  List<Object?> get props => const [];
}

class LoadedState extends ThemeState {
  const LoadedState({required this.theme, required this.darkTheme});

  @override
  final ThemeModel? theme;

  @override
  final DarkThemeModel? darkTheme;

  @override
  List<Object?> get props => [theme, darkTheme];
}

class ErrorState extends ThemeState {
  const ErrorState(this.failure, {this.theme, this.darkTheme});

  final Failure failure;

  @override
  final ThemeModel? theme;

  @override
  final DarkThemeModel? darkTheme;

  @override
  List<Object?> get props => [failure, theme, darkTheme];
}

class ThemeStateNotifier extends StateNotifier<ThemeState> {
  ThemeStateNotifier(this.repo) : super(const EmptyState());

  final ThemeRepo repo;

  Future<void> loadTheme() async {
    state = const Loading();

    final data = await Future.wait([repo.getTheme(), repo.getDarkTheme()]);

    state = data[0]
        .bind(
          (theme) => data[1].map(
            (darkTheme) => LoadedState(
              theme: theme as ThemeModel,
              darkTheme: darkTheme as DarkThemeModel,
            ),
          ),
        )
        .fold(ErrorState.new, id);
  }

  Future<void> setTheme(ThemeModel theme) async {
    state = (await repo.setTheme(theme)).fold(
      (failure) =>
          ErrorState(failure, theme: state.theme, darkTheme: state.darkTheme),
      (_) => LoadedState(theme: theme, darkTheme: state.darkTheme),
    );
  }

  Future<void> setDarkTheme(DarkThemeModel darkTheme) async {
    state = (await repo.setDarkTheme(darkTheme)).fold(
      (failure) =>
          ErrorState(failure, theme: state.theme, darkTheme: state.darkTheme),
      (_) => LoadedState(theme: state.theme, darkTheme: darkTheme),
    );
  }
}

final themeStateNotifierProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeState>(
  (ref) => ThemeStateNotifier(ref.watch(themeRepoProvider)),
);

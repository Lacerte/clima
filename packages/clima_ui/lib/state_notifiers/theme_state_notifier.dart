import 'package:clima_core/failure.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_data/repos/theme_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

@sealed
@immutable
abstract class ThemeState extends Equatable {
  const ThemeState();

  ThemeModel get theme;
}

class Empty extends ThemeState {
  const Empty();

  @override
  ThemeModel get theme => null;

  @override
  List<Object> get props => const [];
}

class Loading extends ThemeState {
  const Loading();

  @override
  ThemeModel get theme => null;

  @override
  List<Object> get props => const [];
}

class Loaded extends ThemeState {
  const Loaded(this.theme);

  @override
  final ThemeModel theme;

  @override
  List<Object> get props => [theme];
}

class Error extends ThemeState {
  const Error(this.failure, {this.theme});

  final Failure failure;

  @override
  final ThemeModel theme;

  @override
  List<Object> get props => [failure, theme];
}

class ThemeStateNotifier extends StateNotifier<ThemeState> {
  ThemeStateNotifier(this.repo) : super(const Empty());

  final ThemeRepo repo;

  Future<void> loadTheme() async {
    state = const Loading();
    final data = await repo.getTheme();
    state = data.fold((failure) => Error(failure), (theme) => Loaded(theme));
  }

  Future<void> setTheme(ThemeModel theme) async {
    (await repo.setTheme(theme)).fold((failure) {
      state = Error(failure, theme: state.theme);
    }, (_) {
      state = Loaded(theme);
    });
  }
}

final themeStateNotifierProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeState>(
        (ref) => ThemeStateNotifier(ref.watch(themeRepoProvider)));

final themeProvider =
    Provider((ref) => ref.watch(themeStateNotifierProvider).theme);

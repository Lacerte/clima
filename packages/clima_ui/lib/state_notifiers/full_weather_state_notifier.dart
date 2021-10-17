import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/full_weather.dart';
import 'package:clima_domain/use_cases/get_city.dart';
import 'package:clima_domain/use_cases/get_full_weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

@sealed
@immutable
abstract class FullWeatherState extends Equatable {
  const FullWeatherState();

  FullWeather? get fullWeather;
}

class Empty extends FullWeatherState {
  const Empty();

  @override
  FullWeather? get fullWeather => null;

  @override
  List<Object?> get props => const [];
}

class Loading extends FullWeatherState {
  const Loading({this.fullWeather});

  @override
  final FullWeather? fullWeather;

  @override
  List<Object?> get props => [fullWeather];
}

class Loaded extends FullWeatherState {
  const Loaded(this.fullWeather);

  @override
  final FullWeather fullWeather;

  @override
  List<Object?> get props => [fullWeather];
}

class Error extends FullWeatherState {
  const Error(this.failure, {required this.fullWeather});

  final Failure failure;

  @override
  final FullWeather? fullWeather;

  @override
  List<Object?> get props => [failure, fullWeather];
}

class FullWeatherStateNotifier extends StateNotifier<FullWeatherState> {
  FullWeatherStateNotifier(this.getFullWeather, this.getCity)
      : super(const Empty());

  final GetFullWeather getFullWeather;

  final GetCity getCity;

  Future<Either<Failure, FullWeather>> _loadWeather() async {
    final cityEither = await getCity(const NoParams());

    if (cityEither is Left) {
      return Left((cityEither as Left<Failure, City>).value);
    }

    final city = (cityEither as Right<Failure, City>).value;

    return getFullWeather(GetFullWeatherParams(city: city));
  }

  Future<void> loadFullWeather() async {
    state = Loading(fullWeather: state.fullWeather);

    state = (await _loadWeather()).fold(
      (failure) => Error(failure, fullWeather: state.fullWeather),
      (fullWeather) => Loaded(fullWeather),
    );
  }
}

final fullWeatherStateNotifierProvider =
    StateNotifierProvider<FullWeatherStateNotifier, FullWeatherState>(
  (ref) => FullWeatherStateNotifier(
    ref.watch(getFullWeatherProvider),
    ref.watch(getCityProvider),
  ),
);

import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/use_cases/get_city.dart';
import 'package:clima_domain/use_cases/get_forecasts.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

@sealed
@immutable
abstract class ForecastsState extends Equatable {
  const ForecastsState();

  Forecasts? get forecasts;
}

class Empty extends ForecastsState {
  const Empty();

  @override
  Forecasts? get forecasts => null;

  @override
  List<Object?> get props => const [];
}

class Loading extends ForecastsState {
  const Loading({this.forecasts});

  @override
  final Forecasts? forecasts;

  @override
  List<Object?> get props => [forecasts];
}

class Loaded extends ForecastsState {
  const Loaded(this.forecasts);

  @override
  final Forecasts forecasts;

  @override
  List<Object?> get props => [forecasts];
}

class Error extends ForecastsState {
  const Error(this.failure, {required this.forecasts});

  final Failure failure;

  @override
  final Forecasts? forecasts;

  @override
  List<Object?> get props => [failure, forecasts];
}

class ForecastsStateNotifier extends StateNotifier<ForecastsState> {
  ForecastsStateNotifier(this.getForecasts, this.getCity)
      : super(const Empty());

  final GetForecasts getForecasts;

  final GetCity getCity;

  Future<Either<Failure, Forecasts>> _loadForecasts() async {
    final cityEither = await getCity(const NoParams());

    if (cityEither is Left) {
      return Left((cityEither as Left<Failure, City>).value);
    }

    final city = (cityEither as Right<Failure, City>).value;

    return getForecasts(GetForecastsParams(city: city));
  }

  Future<void> loadForecasts() async {
    state = Loading(forecasts: state.forecasts);

    state = (await _loadForecasts()).fold(
      (failure) => Error(failure, forecasts: state.forecasts),
      (weather) => Loaded(weather),
    );
  }
}

final forecastsStateNotifierProvider =
    StateNotifierProvider<ForecastsStateNotifier, ForecastsState>(
  (ref) => ForecastsStateNotifier(
    ref.watch(getForecastsProvider),
    ref.watch(getCityProvider),
  ),
);

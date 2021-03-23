import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/use_cases/get_city.dart';
import 'package:clima_domain/use_cases/get_forecasts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

@sealed
@immutable
abstract class ForecastsState extends Equatable {
  const ForecastsState();
}

class Empty extends ForecastsState {
  const Empty();

  @override
  List<Object> get props => const [];
}

class Loading extends ForecastsState {
  const Loading({this.forecasts});

  final Forecasts forecasts;

  @override
  List<Object> get props => [forecasts];
}

class Loaded extends ForecastsState {
  const Loaded(this.forecasts);

  final Forecasts forecasts;

  @override
  List<Object> get props => [forecasts];
}

class Error extends ForecastsState {
  const Error(this.failure, {@required this.forecasts});

  final Failure failure;

  final Forecasts forecasts;

  @override
  List<Object> get props => [failure, forecasts];
}

class ForecastsStateNotifier extends StateNotifier<ForecastsState> {
  ForecastsStateNotifier(this.getForecasts, this.getCity)
      : super(const Empty());

  final GetForecasts getForecasts;

  final GetCity getCity;

  Forecasts get _currentForecasts {
    final state = this.state;

    if (state is Loaded) {
      return state.forecasts;
    } else if (state is Loading) {
      return state.forecasts;
    } else if (state is Error) {
      return state.forecasts;
    } else {
      return null;
    }
  }

  Future<Either<Failure, Forecasts>> _loadForecasts() async {
    final cityEither = await getCity(const NoParams());

    if (cityEither.isLeft()) {
      return Left((cityEither as Left<Failure, City>).value);
    }

    final city = (cityEither as Right<Failure, City>).value;

    return getForecasts(GetForecastsParams(city: city));
  }

  Future<void> loadForecasts() async {
    final forecasts = _currentForecasts;

    state = Loading(forecasts: forecasts);

    state = (await _loadForecasts()).fold(
      (failure) => Error(failure, forecasts: forecasts),
      (weather) => Loaded(weather),
    );
  }

  Future<Either<Failure, void>> reloadForecasts() async =>
      (await _loadForecasts()).map((weather) => state = Loaded(weather));
}

final forecastsStateNotifierProvider =
    StateNotifierProvider((ref) => ForecastsStateNotifier(
          ref.watch(getForecastsProvider),
          ref.watch(getCityProvider),
        ));

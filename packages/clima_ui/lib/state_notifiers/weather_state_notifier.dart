import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_domain/use_cases/get_city.dart';
import 'package:clima_domain/use_cases/get_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

@sealed
@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class Empty extends WeatherState {
  const Empty();

  @override
  List<Object> get props => const [];
}

class Loading extends WeatherState {
  const Loading();

  @override
  List<Object> get props => const [];
}

class Loaded extends WeatherState {
  const Loaded(this.weather);

  final Weather weather;

  @override
  List<Object> get props => [weather];
}

class Error extends WeatherState {
  const Error(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}

class WeatherStateNotifier extends StateNotifier<WeatherState> {
  WeatherStateNotifier(this.getWeather, this.getCity) : super(const Empty());

  final GetWeather getWeather;

  final GetCity getCity;

  Future<Either<Failure, Weather>> _loadWeather() async {
    final cityEither = await getCity(const NoParams());

    if (cityEither.isLeft()) {
      return Left((cityEither as Left<Failure, City>).value);
    }

    final city = (cityEither as Right<Failure, City>).value;

    return getWeather(GetWeatherParams(city: city));
  }

  Future<void> loadWeather() async {
    state = const Loading();
    state = (await _loadWeather())
        .fold((failure) => Error(failure), (weather) => Loaded(weather));
  }

  Future<Either<Failure, void>> reloadWeather() async =>
      (await _loadWeather()).map((weather) => state = Loaded(weather));
}

final weatherStateNotifierProvider =
    StateNotifierProvider((ref) => WeatherStateNotifier(
          ref.watch(getWeatherProvider),
          ref.watch(getCityProvider),
        ));

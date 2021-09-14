import 'package:clima_core/either.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_domain/use_cases/get_city.dart';
import 'package:clima_domain/use_cases/get_weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

@sealed
@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();

  Weather? get weather;
}

class Empty extends WeatherState {
  const Empty();

  @override
  Weather? get weather => null;

  @override
  List<Object?> get props => const [];
}

class Loading extends WeatherState {
  const Loading({this.weather});

  @override
  final Weather? weather;

  @override
  List<Object?> get props => [weather];
}

class Loaded extends WeatherState {
  const Loaded(this.weather);

  @override
  final Weather weather;

  @override
  List<Object?> get props => [weather];
}

class Error extends WeatherState {
  const Error(this.failure, {required this.weather});

  final Failure failure;

  @override
  final Weather? weather;

  @override
  List<Object?> get props => [failure, weather];
}

class WeatherStateNotifier extends StateNotifier<WeatherState> {
  WeatherStateNotifier(this.getWeather, this.getCity) : super(const Empty());

  final GetWeather getWeather;

  final GetCity getCity;

  Future<Either<Failure, Weather>> _loadWeather() async {
    final cityEither = await getCity(const NoParams());

    if (cityEither is Left) {
      return Left((cityEither as Left<Failure, City>).value);
    }

    final city = (cityEither as Right<Failure, City>).value;

    return getWeather(GetWeatherParams(city: city));
  }

  Future<void> loadWeather() async {
    state = Loading(weather: state.weather);

    state = (await _loadWeather()).fold(
      (failure) => Error(failure, weather: state.weather),
      (weather) => Loaded(weather),
    );
  }
}

final weatherStateNotifierProvider =
    StateNotifierProvider<WeatherStateNotifier, WeatherState>(
        (ref) => WeatherStateNotifier(
              ref.watch(getWeatherProvider),
              ref.watch(getCityProvider),
            ),);

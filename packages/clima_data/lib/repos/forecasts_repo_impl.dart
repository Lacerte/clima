import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/forecast_remote_data_source.dart';
import 'package:clima_data/data_sources/weather_memoized_data_source.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class ForcastsRepoImpl implements ForcastsRepo {
  final ForecastsRemoteDataSource remoteDataSource;

  final WeatherMemoizedDataSource memoizedDataSource;

  final Connectivity connectivity;

  ForcastsRepoImpl({
    @required this.remoteDataSource,
    @required this.memoizedDataSource,
    @required this.connectivity,
  });

  @override
  Future<Either<Failure, Weather>> getWeather(City city) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return Left(const NoConnection());
    } else {
      final memoizedWeather = await memoizedDataSource.getMemoizedWeather();

      if (memoizedWeather.isLeft() ||
          memoizedWeather.all(
              (weather) => weather != null && weather.cityName == city.name)) {
        return memoizedWeather;
      }

      final forcasts = await remoteDataSource.getWeather(city);

      await forcasts.map(memoizedDataSource.setWeather).getOrElse(() => null);

      return forcasts;
    }
  }


final forecastsRepoImplProvider = Provider(
  (ref) => ForcastsRepoImpl(
    remoteDataSource: ref.watch(forecastRemoteDataSourceProvider),
    memoizedDataSource: ref.watch(weatherMemoizedDataSourceProvider),
    connectivity: Connectivity(),
  ),
);

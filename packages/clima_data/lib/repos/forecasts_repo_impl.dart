import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/forecast_remote_data_source.dart';
import 'package:clima_data/data_sources/forecasts_memoized_data_source.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class ForecastsRepoImpl implements ForecastsRepo {
  final ForecastsRemoteDataSource remoteDataSource;

  final ForecastsMemoizedDataSource memoizedDataSource;

  final Connectivity connectivity;

  ForecastsRepoImpl({
    @required this.remoteDataSource,
    @required this.memoizedDataSource,
    @required this.connectivity,
  });

  @override
  Future<Either<Failure, Forecasts>> getForecasts(City city) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return Left(const NoConnection());
    } else {
      final memoizedForecasts = await memoizedDataSource.getMemoizedForecasts();

      if (memoizedForecasts.isLeft() ||
          memoizedForecasts.all(
              (weather) => weather != null && weather.cityName == city.name)) {
        return memoizedForecasts;
      }

      final forecasts = await remoteDataSource.getForecasts(city);

      await forecasts
          .map(memoizedDataSource.setForecasts)
          .getOrElse(() => null);

      return forecasts;
    }
  }

  final forecastsRepoImplProvider = Provider(
    (ref) => ForecastsRepoImpl(
      remoteDataSource: ref.watch(forecastRemoteDataSourceProvider),
      memoizedDataSource: ref.watch(forecastsMemoizedDataSourceProvider),
      connectivity: Connectivity(),
    ),
  );
}

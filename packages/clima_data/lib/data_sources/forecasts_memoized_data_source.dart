import 'dart:math';

import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class ForecastsMemoizedDataSource {
  Future<Either<Failure, void>> setForecasts(Forecasts forecasts);

  Future<Either<Failure, Forecasts>> getMemoizedForecasts();
}

class ForecastsMemoizedDataSourceImpl implements ForecastsMemoizedDataSource {
  Forecasts _forecasts;

  DateTime _fetchingTime;

  static const _invalidationDuration = Duration(minutes: 1);

  @override
  Future<Either<Failure, Forecasts>> getMemoizedForecasts() async {
    if (_forecasts == null) return Right(null);

    if (DateTime.now().difference(_fetchingTime) >= _invalidationDuration) {
      _forecasts = null;
      _fetchingTime = null;
      return Right(null);
    }

    // Minor delay so that users won't think the fetching is broken or
    // something.
    await Future.delayed(
      Duration(
        milliseconds: 200 + Random().nextInt(800 - 200),
      ),
    );

    return Right(_forecasts);
  }

  @override
  Future<Either<Failure, void>> setForecasts(Forecasts forecasts) async {
    _fetchingTime = DateTime.now();
    _forecasts = forecasts;
    return Right(null);
  }
}

final forecastsMemoizedDataSourceProvider =
    Provider<ForecastsMemoizedDataSource>(
  (ref) => ForecastsMemoizedDataSourceImpl(),
);

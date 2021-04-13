import 'package:charts_flutter/flutter.dart' as charts;
import 'package:clima_domain/entities/weather.dart';
import 'package:flutter/material.dart';

/// Renders a line chart from forecast data
/// x axis - date
/// y axis - temperature
class TemperatureLineChart extends StatelessWidget {
  const TemperatureLineChart(this.weathers, {this.animate});

  final List<Weather> weathers;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: charts.TimeSeriesChart(
        [
          charts.Series<Weather, DateTime>(
            id: 'Temperature',
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Theme.of(context).accentColor,
            ),
            domainFn: (Weather weather, _) => weather.date,
            measureFn: (Weather weather, _) => weather.temperature,
            data: weathers,
          ),
        ],
        animate: animate,
        animationDuration: const Duration(milliseconds: 500),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            zeroBound: false,
          ),
        ),
      ),
    );
  }
}

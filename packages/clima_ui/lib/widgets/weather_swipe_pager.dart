import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'current_conditions.dart';
import 'temperature_line_chart.dart';

class WeatherSwipePager extends StatelessWidget {
  WeatherSwipePager({
    @required this.weather,
    Key key,
  }) : super(key: key);

  Forecasts forecasts;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Swiper(
        itemCount: 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CurrentConditions(weather: weather);
          } else if (index == 1) {
            return TemperatureLineChart(
              forecasts.forecasts,
              animate: true,
            );
          }
          return const SizedBox.shrink();
        },
        pagination: SwiperPagination(
          margin: const EdgeInsets.all(5.0),
          builder: DotSwiperPaginationBuilder(
              size: 5,
              activeSize: 5,
              color: Theme.of(context).accentColor.withOpacity(0.4),
              activeColor: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}

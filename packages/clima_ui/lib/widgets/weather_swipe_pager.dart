import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'current_conditions.dart';
import 'temperature_line_chart.dart';

class WeatherSwipePager extends HookWidget {
  const WeatherSwipePager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecasts =
        useProvider(forecastsStateNotifierProvider.state).forecasts;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Swiper(
        itemCount: 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const CurrentConditions();
          } else if (index == 1) {
            // TODO: show a proper error or something.
            return TemperatureLineChart(
              forecasts?.forecasts ?? const [],
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

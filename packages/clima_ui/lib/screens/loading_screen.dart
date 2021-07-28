import 'dart:async';

import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart' as t;
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:clima_ui/utilities/failure_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'weather_screen.dart';

class LoadingScreen extends HookWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = useProvider(t.themeProvider);
    final weatherStateNotifier =
        useProvider(weatherStateNotifierProvider.notifier);
    final forecastsStateNotifier =
        useProvider(f.forecastsStateNotifierProvider.notifier);

    useEffect(
      () {
        Future<void> load() async {
          await Future.microtask(() async {
            await Future.wait(
              [
                weatherStateNotifier.loadWeather(),
                forecastsStateNotifier.loadForecasts(),
              ],
            );
          });

          final removeListener = weatherStateNotifier.addListener((state) {
            if (state is Error) {
              showFailureSnackBar(context,
                  failure: state.failure, onRetry: load);
            }

            if (state is Loaded) {
              final removeListener =
                  forecastsStateNotifier.addListener((state) {
                if (state is f.Error) {
                  showFailureSnackBar(context,
                      failure: state.failure, onRetry: load);
                }

                if (state is f.Loaded) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const WeatherScreen(),
                    ),
                  );
                }
              });

              removeListener();
            }
          });

          removeListener();
        }

        load();

        return null;
      },
      [weatherStateNotifier, forecastsStateNotifier],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SpinKitDoubleBounce(
          color: theme != t.AppTheme.light ? Colors.white : Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}

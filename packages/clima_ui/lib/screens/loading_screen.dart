import 'dart:async';

import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart';
import 'package:clima_ui/themes/clima_theme.dart';
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
    final fullWeatherStateNotifier =
        useProvider(fullWeatherStateNotifierProvider.notifier);

    useEffect(
      () {
        Future<void> load() async {
          await Future.microtask(() async {
            await fullWeatherStateNotifier.loadFullWeather();
          });

          final removeListener = fullWeatherStateNotifier.addListener((state) {
            if (state is Error) {
              showFailureSnackBar(
                context,
                failure: state.failure,
                onRetry: load,
              );
            }

            if (state is Loaded) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeatherScreen(),
                ),
              );
            }
          });

          removeListener();
        }

        load();

        return null;
      },
      [fullWeatherStateNotifier],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SpinKitDoubleBounce(
          color: ClimaTheme.of(context).loadingIndicatorColor,
          size: 100.0,
        ),
      ),
    );
  }
}

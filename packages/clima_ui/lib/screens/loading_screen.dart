import 'dart:async';

import 'package:clima_ui/main.dart';
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:clima_ui/utilities/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulHookWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);
    final weatherStateNotifier = useProvider(weatherStateNotifierProvider);

    useEffect(
      () {
        Future<void> load() async {
          await Future.microtask(weatherStateNotifier.loadWeather);

          final removeListener = weatherStateNotifier.addListener((state) {
            if (state is Error) {
              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(
                failureSnackbar(
                  failure: state.failure,
                  onRetry: load,
                ),
              );
            }

            if (state is Loaded) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LocationScreen(),
                ),
              );
            }
          });

          removeListener();
        }

        load();

        return null;
      },
      [weatherStateNotifier],
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SpinKitDoubleBounce(
          color: _themeState.isDarkTheme ? Colors.white : Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}

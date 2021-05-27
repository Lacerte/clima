import 'package:clima_data/repos/city_repo_impl.dart';
import 'package:clima_data/repos/forecasts_repo_impl.dart';
import 'package:clima_data/repos/weather_repo_impl.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart'
    show themeStateNotifierProvider, themeProvider, AppTheme;
import 'package:clima_ui/themes/dark_theme.dart';
import 'package:clima_ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'screens/loading_screen.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        cityRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(cityRepoImplProvider))),
        weatherRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(weatherRepoImplProvider))),
        forecastsRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(forecastsRepoImplProvider))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final themeStateNotifier = useProvider(themeStateNotifierProvider.notifier);

    useEffect(() {
      themeStateNotifier.loadTheme();

      return null;
    }, [themeStateNotifier]);

    final theme = useProvider(themeProvider);

    useEffect(() {
      switch (theme) {
        case AppTheme.darkGrey:
        case AppTheme.black:
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
            statusBarColor: Colors.black,
          ));
          break;

        case AppTheme.light:
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xFFF2F2F2),
            statusBarColor: Color(0xFFF2F2F2),
          ));
          break;
      }

      return null;
    }, [theme]);

    if (theme == null) return const SizedBox.shrink();

    return MaterialApp(
      theme: () {
        switch (theme) {
          case AppTheme.light:
            return lightTheme;

          // TODO: make black have its own theme.
          case AppTheme.black:
          case AppTheme.darkGrey:
            return darkTheme;
            throw Error();
        }
      }(),
      home: const LoadingScreen(),
    );
  }
}

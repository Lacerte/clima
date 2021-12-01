/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_data/providers.dart';
import 'package:clima_data/repos/city_repo_impl.dart';
import 'package:clima_data/repos/full_weather_repo.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:clima_domain/repos/full_weather_repo.dart';
import 'package:clima_ui/screens/loading_screen.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart' as t;
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart'
    show themeStateNotifierProvider;
import 'package:clima_ui/themes/black_theme.dart';
import 'package:clima_ui/themes/dark_theme.dart';
import 'package:clima_ui/themes/light_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'themes/clima_theme.dart';

Future<void> main() async {
  // Unless you do this, using method channels (like `SharedPreferences` does)
  // before running `runApp` throws an error.
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        cityRepoProvider.overrideWithProvider(
          Provider((ref) => ref.watch(cityRepoImplProvider)),
        ),
        fullWeatherRepoProvider.overrideWithProvider(
          Provider((ref) => ref.watch(fullWeatherRepoImplProvider)),
        ),
      ],
      child: DevicePreview(
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final themeStateNotifier = useProvider(themeStateNotifierProvider.notifier);

    useEffect(
      () {
        themeStateNotifier.loadTheme();

        return null;
      },
      [themeStateNotifier],
    );

    final themeState = useProvider(themeStateNotifierProvider);

    if (themeState is t.EmptyState || themeState is t.Loading) {
      return const SizedBox.shrink();
    }

    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: (context, child) {
            final ClimaThemeData climaTheme;

            switch (Theme.of(context).brightness) {
              case Brightness.light:
                climaTheme = lightClimaTheme;
                break;

              case Brightness.dark:
                climaTheme = {
                  DarkThemeModel.black: blackClimaTheme,
                  DarkThemeModel.darkGrey: darkGreyClimaTheme,
                }[themeState.darkTheme]!;
            }

            return DevicePreview.appBuilder(
              context,
              ClimaTheme(data: climaTheme, child: child!),
            );
          },
          home: const LoadingScreen(),
          theme: lightTheme,
          darkTheme: {
            DarkThemeModel.black: blackTheme,
            DarkThemeModel.darkGrey: darkGreyTheme,
          }[themeState.darkTheme],
          themeMode: const {
            ThemeModel.systemDefault: ThemeMode.system,
            ThemeModel.light: ThemeMode.light,
            ThemeModel.dark: ThemeMode.dark,
          }[themeState.theme],
        );
      },
    );
  }
}

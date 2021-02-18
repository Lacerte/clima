import 'package:clima_data/repos/city_repo_impl.dart';
import 'package:clima_data/repos/weather_repo_impl.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'screens/loading_screen.dart';
import 'themes/theme_model.dart';

final themeStateNotifier = ChangeNotifierProvider((ref) => ThemeModel());

void main() {
  runApp(
    ProviderScope(
      overrides: [
        cityRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(cityRepoImplProvider))),
        weatherRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(weatherRepoImplProvider))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _themeState = watch(themeStateNotifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeState.setTheme(),
      home: LoadingScreen(),
    );
  }
}

import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'themes/theme_model.dart';

final themeStateNotifier = ChangeNotifierProvider((ref) => ThemeModel());

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
  ThemeModel().barsColor();
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _themeState = watch(themeStateNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeState.currentTheme,
      home: LoadingScreen(),
    );
  }
}

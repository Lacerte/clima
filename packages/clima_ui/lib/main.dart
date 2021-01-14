import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/loading_screen.dart';
import 'themes/theme_model.dart';

final themeStateNotifier = ChangeNotifierProvider((ref) => ThemeModel());

void main() {
  runApp(
    ProviderScope(
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

import 'package:clima/features/clima/presentation/screens/loading_screen.dart';
import 'package:clima/features/clima/presentation/themes/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

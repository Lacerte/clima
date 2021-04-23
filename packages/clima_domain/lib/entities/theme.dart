import 'package:riverpod/riverpod.dart';

enum AppTheme { dark, light }

final themeProvider = StateProvider((ref) => AppTheme.light);

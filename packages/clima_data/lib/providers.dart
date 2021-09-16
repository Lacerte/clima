import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final connectivityProvider = Provider((ref) => Connectivity());

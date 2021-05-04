import 'package:riverpod/riverpod.dart';

enum UnitSystem { metric, imperial }

final unitProvider = StateProvider((ref) => UnitSystem.metric);

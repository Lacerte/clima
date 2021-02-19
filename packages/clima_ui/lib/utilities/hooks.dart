import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

/// Creates a [FloatingSearchBarController].
FloatingSearchBarController useFloatingSearchBarController() {
  final controller = useMemoized(
    () => FloatingSearchBarController(),
    const [],
  );

  useEffect(() => controller.dispose, const []);

  return controller;
}

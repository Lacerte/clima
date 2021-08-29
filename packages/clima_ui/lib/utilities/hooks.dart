/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:flutter/widgets.dart';
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

/// Creates a [GlobalKey] that stays the same tilll the widget's lifetime ends.
GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() =>
    // An empty list is given to `useMemoized` so that the global key will
    // never be reset. See `useMemoized`'s documentation.
    useMemoized(() => GlobalKey<T>(), const []);

/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:device_preview/device_preview.dart';

import 'main.dart' as m;

Future<void> main() => m.main(
      builder: DevicePreview.appBuilder,
      topLevelBuilder: (widget) => DevicePreview(builder: (_) => widget),
      getLocale: DevicePreview.locale,
    );

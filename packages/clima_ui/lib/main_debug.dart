import 'package:device_preview/device_preview.dart';

import 'main.dart' as m;

Future<void> main() => m.main(
      builder: DevicePreview.appBuilder,
      topLevelBuilder: (widget) => DevicePreview(builder: (_) => widget),
      getLocale: DevicePreview.locale,
    );

import 'package:clima_ui/main_common.dart';
import 'flavor_config.dart';

void main() {
  mainCommon(
    config: FlavorConfig(
      flavorName: 'Google Play Store',
      showDonateButton: false,
    ),
  );
}

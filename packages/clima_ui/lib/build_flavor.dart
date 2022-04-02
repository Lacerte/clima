enum BuildFlavor { default_, googlePlay }

const _buildFlavorString = bool.hasEnvironment('buildFlavor')
    ? String.fromEnvironment('buildFlavor')
    : null;

const buildFlavor = _buildFlavorString == 'googleplay'
    ? BuildFlavor.googlePlay
    : BuildFlavor.default_;

void validateBuildFlavor() {
  if (_buildFlavorString != 'googleplay' && _buildFlavorString != null) {
    throw Exception(
      'Invalid flavor $_buildFlavorString, valid flavors: googleplay',
    );
  }
}

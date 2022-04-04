/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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

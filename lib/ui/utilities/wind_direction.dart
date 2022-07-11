/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/// Returns the wind direction in the shape of an [arrow] that corresponds to the given `weatherDirection`.
String getWeatherDirection(double weatherDirection) {
  if (weatherDirection == 0) {
    return '→';
  } else if (weatherDirection == 360) {
    return '→';
  } else if (weatherDirection < 90) {
    return '↗';
  } else if (weatherDirection == 90) {
    return '↑';
  } else if (weatherDirection > 90) {
    return '↖';
  } else if (weatherDirection == 180) {
    return '←';
  } else if (weatherDirection > 180) {
    return '↙';
  } else if (weatherDirection == 270) {
    return '↓';
  } else if (weatherDirection > 270) {
    return '↘';
  }
  return '';
}

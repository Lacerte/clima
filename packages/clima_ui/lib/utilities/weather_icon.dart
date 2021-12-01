/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/// Returns the weather icon that corresponds to the given `iconCode`.
String getWeatherIcon(String iconCode) {
  switch (iconCode) {
    case '01d':
      return 'assets/day.svg';

    case '01n':
      return 'assets/night.svg';

    case '02d':
      return 'assets/cloudy_day.svg';

    case '02n':
      return 'assets/cloudy_night.svg';

    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return 'assets/cloudy.svg';

    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return 'assets/rainy.svg';

    case '11d':
    case '11n':
      return 'assets/thunder.svg';

    case '13d':
    case '13n':
      return 'assets/snowy.svg';

    // TODO: Add smog icon
    // case '50d':
    // case '50n':

    default:
      return 'assets/day.svg';
  }
}

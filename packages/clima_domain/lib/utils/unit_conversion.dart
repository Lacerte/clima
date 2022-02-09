/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

double convertCelsiusToFahrenheit(double value) => 9 * value / 5 + 32;

double convertFahrenheitToCelsius(double value) => 5 * (value - 32) / 9;

double convertKilometersPerHourToMilesPerHour(double value) => value * 0.621371;

double convertMilesPerHourToKilometersPerHour(double value) => value * 1.609344;

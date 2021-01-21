import 'package:flutter/material.dart';

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}

/// Exposes specific weather icons
/// Has all weather conditions specified by open weather maps API
/// https://openweathermap.org/weather-conditions
// hex values and ttf file from https://erikflowers.github.io/weather-icons/
class WeatherIcons {
  static const IconData clearDay = _IconData(0xf00d);
  static const IconData clearNight = _IconData(0xf02e);

  static const IconData fewCloudsDay = _IconData(0xf002);
  static const IconData fewCloudsNight = _IconData(0xf081);

  static const IconData cloudsDay = _IconData(0xf07d);
  static const IconData cloudsNight = _IconData(0xf080);

  static const IconData showerRainDay = _IconData(0xf009);
  static const IconData showerRainNight = _IconData(0xf029);

  static const IconData rainDay = _IconData(0xf008);
  static const IconData rainNight = _IconData(0xf028);

  static const IconData thunderStormDay = _IconData(0xf010);
  static const IconData thunderStormNight = _IconData(0xf03b);

  static const IconData snowDay = _IconData(0xf00a);
  static const IconData snowNight = _IconData(0xf02a);

  static const IconData mistDay = _IconData(0xf003);
  static const IconData mistNight = _IconData(0xf04a);
}

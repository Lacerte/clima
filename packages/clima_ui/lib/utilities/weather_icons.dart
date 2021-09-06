import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//returns the right weather icon for the right condition.

IconData getIconData(String iconCode) {
  switch (iconCode) {
    case '01d':
      return FontAwesomeIcons.sun;
    case '01n':
      return FontAwesomeIcons.moon;
    case '02d':
      return FontAwesomeIcons.cloudSun;
    case '02n':
      return FontAwesomeIcons.cloudMoon;
    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return FontAwesomeIcons.cloud;
    case '09d':
      return FontAwesomeIcons.cloudSunRain;
    case '09n':
      return FontAwesomeIcons.cloudMoonRain;
    case '10d':
    case '10n':
      return FontAwesomeIcons.cloudRain;
    case '11d':
    case '11n':
      return FontAwesomeIcons.pooStorm;
    case '13d':
    case '13n':
      return FontAwesomeIcons.snowflake;
    case '50d':
    case '50n':
      return FontAwesomeIcons.smog;
    default:
      return FontAwesomeIcons.sun;
  }
}

import 'package:clima/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final container = ProviderContainer();
final _themeState = container.read(themeStateNotifier);

const TextStyle kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const TextStyle kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Spartan MB',
);

const TextStyle kConditionTextStyle = TextStyle(
  fontSize: 50.0,
);

InputDecoration kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: _themeState.isDarkTheme
      ? const Color(0xFF171717)
      : const Color(0xFFFAFAFA),
  icon: const Icon(
    Icons.location_city,
    //color: Colors.white,
  ),
  hintText: 'Enter city name',
  hintStyle: const TextStyle(
      //color: Colors.grey,
      ),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(color: Colors.grey),
  ),
);

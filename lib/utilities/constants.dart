import 'package:clima/themes/theme_model.dart';
import 'package:flutter/material.dart';

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
  fillColor: ThemeModel().textFieldFillColor(),
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

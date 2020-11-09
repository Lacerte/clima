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
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const TextStyle kConditionTextStyle = TextStyle(
  fontSize: 50.0,
);

const InputDecoration kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide.none,
  ),
);

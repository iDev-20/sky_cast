import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
);

const kConditionTextStyle = TextStyle(fontSize: 100.0);

const kErrorMessageTextStyle = TextStyle(fontSize: 16.0);

final kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
);

const kIconColor = Colors.white;

final kTextFieldInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.all(8),
  filled: true,
  fillColor: Colors.white,
  icon: const Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: const TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
);

const mostlyRain = '';

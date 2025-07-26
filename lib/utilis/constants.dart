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

const kTextFieldInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(8.0),
    filled: true,
    fillColor: Color(0x1FFFFFFF),
    hintText: 'Search for a city',
    hintStyle: TextStyle(color: Color(0x99333333)),
    border: InputBorder.none);

const mostlyRain = '';
const apiKey = 'a97768d238ad7ce82199db665e8ac84d';


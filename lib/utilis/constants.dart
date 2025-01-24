import 'package:flutter/material.dart';
import 'package:sky_cast/resources/app_images.dart';

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
  fillColor: const Color(0x1FFFFFFF),
  prefixIcon: Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    child: AppImages.svgSearchIcon,
  ),
  prefixIconColor: const Color(0x99EBEBF5),
  hintText: 'Search for a city or airport',
  hintStyle: const TextStyle(color: Color(0x99EBEBF5)),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
);

const mostlyRain = '';

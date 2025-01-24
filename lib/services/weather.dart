import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/services/location.dart';
import 'package:sky_cast/services/networking.dart';

const apiKey = 'a97768d238ad7ce82199db665e8ac84d';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapHourlyForecastURL =
    'https://pro.openweathermap.org/data/2.5/forecast/hourly';


class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Future<dynamic> getHourlyForecast() async {
  //   Location location = Location();

  //   await location.getCurrentLocation();
  //   NetworkHelper networkHelper =
  //       NetworkHelper('$openWeatherMapHourlyForecastURL?'
  //           'lat=${location.latitude}&lon=${location.longitude}'
  //           '&appid=$apiKey&units=metric');

  //   var weatherData = await networkHelper.getData();
  //   return weatherData;
  // }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?'
        'lat=${location.latitude}&lon=${location.longitude}'
        '&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String noIdea = '🤷‍';

  Widget getWeatherIcon(int condition) {
    if (condition < 300) {
      return AppImages.svgCloudLightning;
    } else if (condition < 400) {
      return AppImages.svgCloudDrizzleBlue;
    } else if (condition < 600) {
      return AppImages.svgRain;
    } else if (condition < 700) {
      return const Icon(
        Iconsax.cloud_snow,
        size: 30.0,
      );
    } else if (condition < 800) {
      return const Icon(
        Iconsax.textalign_center,
        size: 30.0,
      );
    } else if (condition == 800) {
      return AppImages.svgSunBig;
    } else if (condition <= 804) {
      return const Icon(
        Iconsax.cloud,
        size: 30.0,
      );
    } else {
      return Text(noIdea);
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

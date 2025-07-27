import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/resources/ui_models.dart';
import 'package:sky_cast/services/location.dart';
import 'package:sky_cast/services/networking.dart';
import 'package:sky_cast/utilis/constants.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapHourlyForecastURL =
    'https://pro.openweathermap.org/data/2.5/forecast/hourly';

class WeatherViewModel {
  Future<Weather?> getCityWeather(String cityName) async {
    final url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    final weatherData = await NetworkHelper(
            url: url, errorMessage: 'Error getting city weather')
        .getData();

    if (weatherData == null) return null;
    return Weather.fromJson(weatherData);
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

  Future<Weather?> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    final url = '$openWeatherMapURL?'
        'lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    final weatherData = await NetworkHelper(
            url: url, errorMessage: 'error getting location weather')
        .getData();

    if (weatherData == null) return null;
    return Weather.fromJson(weatherData);
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

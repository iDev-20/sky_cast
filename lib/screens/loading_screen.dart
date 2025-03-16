// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sky_cast/screens/home_screen.dart';
import 'package:sky_cast/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    try {
      var weatherData = await WeatherModel().getLocationWeather();
      List<Map<String, dynamic>> cities = await getCitiesData();

      // String cityTimeZone = 'Africa/Accra';
      // var timeData = await TimeModel().getCityTime(cityTimeZone);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            locationWeather: weatherData,
            cities: cities,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error fetching location data: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              const Text('Failed to fetch weather data. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCitiesData() async {
    List<String> allCities = [
      'Tokyo',
      'London',
      'Lagos',
      'New York',
      'Toronto',
      'Berlin'
    ];
    List<String> randomCities = getRandomCities(allCities, 5);

    List<Map<String, dynamic>> weatherList = [];
    for (String cityName in randomCities) {
      try {
        var cityWeather = await WeatherModel().getCityWeather(cityName);
        if (cityWeather != null) {
          weatherList.add(cityWeather);
        }
      } catch (e) {
        debugPrint('Error fetching weather for $cityName: $e');
      }
    }

    return weatherList;
  }

  List<String> getRandomCities(List<String> cities, int count) {
    cities.shuffle(Random());
    return cities.length > count ? cities.sublist(0, count) : cities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: const Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

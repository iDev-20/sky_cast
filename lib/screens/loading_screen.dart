import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sky_cast/screens/home_screen.dart';
import 'package:sky_cast/services/weather.dart';
import 'package:sky_cast/utilis/navigation.dart';

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
    var weatherData = await WeatherModel().getLocationWeather();

    Navigation.navigateToScreen(
        context: context,
        screen: HomePage(
          // locationWeather: weatherData,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

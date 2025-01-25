// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sky_cast/extensions/date_time_extensions.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/screens/details_screen.dart';
import 'package:sky_cast/services/weather.dart';
import 'package:sky_cast/utilis/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, this.locationWeather, this.cities, this.hourlyForecastData});

  final locationWeather;
  final cities;
  final hourlyForecastData;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSpinner = false;
  String? cityName;
  String? countryName;
  int? temperature;
  int? windSpeed;
  String? weatherDescription;
  int? hourlyForecastTemperature;
  int? humidity;
  int? pressure;
  int? maxTemperature;
  int? minTemperature;
  int? seaLevel;
  int? feelsLike;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      double fl = weatherData['main']['feels_like'];
      feelsLike = fl.toInt();

      pressure = weatherData['main']['pressure'];
      humidity = weatherData['main']['humidity'];
      double minTemp = weatherData['main']['temp_min'];
      minTemperature = minTemp.toInt();
      double maxTemp = weatherData['main']['temp_max'];
      maxTemperature = maxTemp.toInt();
      seaLevel = weatherData['main']['sea_level'];

      countryName = weatherData['sys']['country'];

      cityName = weatherData['name'];

      double speed = weatherData['wind']['speed'];
      windSpeed = speed.toInt();

      weatherDescription = weatherData['weather'][0]['description'];

      // double hourlyForecastTemp = hourlyForecastData['list']['main']['temp'];
      // hourlyForecastTemperature = hourlyForecastTemp.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xFF7F999A),
            Color(0xFFA9A39C),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async {
            var weatherData = await WeatherModel().getLocationWeather();
            updateUI(weatherData);
          },
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AppImages.rainyBackgroundImage,
                              fit: BoxFit.cover),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 78, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      var weatherData = await WeatherModel()
                                          .getLocationWeather();
                                      updateUI(weatherData);
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        AppImages.svgLocationIcon,
                                        const SizedBox(width: 12),
                                        Text(
                                          '$cityName, $countryName',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Urbanist',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigation.navigateToScreen(
                                          context: context,
                                          screen: DetailsScreen(
                                            cities: widget.cities,
                                          ));
                                    },
                                    child: const Icon(Icons.menu,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 29),
                              Text(
                                'Today, ${DateTime.now().myCustomDateTime()}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist'),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '$temperature',
                                          style: const TextStyle(
                                              fontFamily: 'Inter_18pt',
                                              color: Colors.white,
                                              fontSize: 128,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(0.0, -57.0),
                                            child: const Text(
                                              '°C',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: Text(
                                          '$weatherDescription',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      AppImages.svgCloudDrizzle,
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                'feels like $feelsLike°C',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                    color: const Color(0x1FFFFFFF),
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(
                                      color: const Color(0xFFD9D9D9),
                                    )),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        singleParameter(
                                            statusIcon: const Icon(
                                              Iconsax.wind_25,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            status: '${windSpeed}m/s',
                                            statusTitle: 'Wind'),
                                        singleParameter(
                                            statusIcon: const Icon(
                                              Iconsax.sun_15,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            status: '$maxTemperature°C',
                                            statusTitle: 'Max'),
                                        singleParameter(
                                            statusIcon: const Icon(
                                              Iconsax.sun_1,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            status: '$minTemperature°C',
                                            statusTitle: 'Min'),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    line(),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        singleParameter(
                                            statusIcon: const Icon(
                                              Iconsax.drop3,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            status: '$humidity%',
                                            statusTitle: 'Humidity'),
                                        singleParameter(
                                            statusIcon: AppImages.svgWind,
                                            status: '${pressure}hPa',
                                            statusTitle: 'Pressure'),
                                        singleParameter(
                                            statusIcon: const Icon(
                                              Iconsax.chart_35,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            status: '${seaLevel}m',
                                            statusTitle: 'Sea-Level'),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 267,
                  padding: const EdgeInsets.only(
                      left: 14, top: 51, right: 19, bottom: 29),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AppImages.bottomContainerBackgroundImage,
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hourly Forecast',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter_28pt',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: hourlyForecast(
                                weatherIcon: AppImages.svgSunBig),
                          ),
                          hourlyForecast(weatherIcon: AppImages.svgCloudSunny),
                          hourlyForecast(
                              weatherIcon: AppImages.svgCloudDrizzleBlue),
                          hourlyForecast(
                              weatherIcon: AppImages.svgCloudLightning),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget singleParameter(
      {required Widget statusIcon,
      required String status,
      required String statusTitle}) {
    return SizedBox(
      child: Column(
        children: [
          statusIcon,
          const SizedBox(height: 5.0),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            statusTitle,
            style: const TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget line() {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(999)),
    );
  }

  Widget hourlyForecast({required Widget weatherIcon}) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20.5),
            decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6), shape: BoxShape.circle),
            child: weatherIcon,
          ),
          const SizedBox(
            height: 9.0,
          ),
          const Text(
            '05:00 AM',
            style: TextStyle(
                color: Color(0xFFA7A7A7),
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 9.0),
          const Text(
            '°C',
            //$hourlyForecastTemperature
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

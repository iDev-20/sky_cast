// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/services/weather.dart';
import 'package:sky_cast/utilis/constants.dart';
import 'package:sky_cast/utilis/navigation.dart';
import 'package:sky_cast/widgets/city_weather_card.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, this.cities});

  final cities;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool showSpinner = false;
  String? cityName;
  String? countryName;
  int? temperature;
  String? weatherStatus;
  Widget? weatherIcon;

  List<CityWeatherCard> cityWeatherCard = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    updateCardUI(widget.cities);

    scrollController.addListener(() {
      setState(() {});
    });
  }

  void updateCardUI(dynamic cities) {
    if (cities == null || cities.isEmpty) {
      setState(() {
        cityWeatherCard.clear();
      });
      return;
    }

    int citiesCount = cities.length;
    int limit = citiesCount > 5 ? 5 : citiesCount;

    cityWeatherCard.clear();

    for (int i = 0; i < limit; i++) {
      var citiesData = cities[i];

      if (citiesData == null ||
          citiesData['main'] == null ||
          citiesData['sys'] == null ||
          citiesData['weather'] == null ||
          citiesData['weather'].isEmpty) {
        continue;
        // Skip invalid or incomplete data
      }
      double temp = citiesData['main']['temp'].toDouble();
      temperature = temp.toInt();

      countryName = citiesData['sys']['country'];

      cityName = citiesData['name'];

      weatherStatus = citiesData['weather'][0]['main'];

      var condition = citiesData['weather'][0]['id'];
      weatherIcon = WeatherModel().getWeatherIcon(condition ?? 0);

      cityWeatherCard.add(CityWeatherCard(
          temperature: temperature ?? 0,
          weatherIcon: weatherIcon ?? const SizedBox(),
          cityName: cityName ?? '',
          weatherStatus: weatherStatus ?? ''));
    }
    setState(() {});
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: AbsorbPointer(
          absorbing: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 78, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigation.back(context: context);
                                  },
                                  child: const Icon(
                                    Icons.chevron_left_rounded,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Weather',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Urbanist',
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            AppImages.svgMenuCircle
                          ],
                        ),
                        const SizedBox(height: 27.0),
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                              color: const Color(0x1FFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.white, width: 0.5)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.white, width: 0.5)),
                                  child: TextField(
                                    cursorColor: const Color(0x99333333),
                                    style: const TextStyle(color: Colors.black),
                                    decoration: kTextFieldInputDecoration,
                                    onChanged: (value) {
                                      cityName = value;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                width: 40,
                                decoration: const BoxDecoration(
                                    color: null,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    )),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    // if (cityName != null) {
                                    //   var weatherData = await WeatherModel()
                                    //       .getCityWeather(cityName ?? '');
                                    //   // updateUI(weatherData);
                                    // }
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Color(0x99333333),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // try {
                          //   var newCities = await WeatherModel()
                          //       .getCityWeather(cityName ?? '');

                          //   if (newCities != null) {
                          //     updateCardUI(newCities);
                          //   } else {
                          //     setState(() {
                          //       cityWeatherCard.clear();
                          //     });
                          //   }
                          // } catch (e) {
                          //   print('Error fetching cities: $e');
                          // }
                        },
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20.0),
                            shrinkWrap: true,
                            itemCount: cityWeatherCard.length,
                            itemBuilder: (context, index) {
                              return cityWeatherCard[index];
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

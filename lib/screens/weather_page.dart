// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sky_cast/resources/ui_models.dart';
import 'package:sky_cast/services/weather_view_model.dart';
import 'package:sky_cast/utilis/constants.dart';
import 'package:sky_cast/utilis/navigation.dart';
import 'package:sky_cast/widgets/city_weather_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, this.cities});

  final cities;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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

  void updateCardUI(List<dynamic>? cities) {
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

      try {
        final weather = Weather.fromJson(citiesData);
        final conditionId = citiesData['weather'][0]['main'];
        final icon = WeatherViewModel().getWeatherIcon(conditionId);

        cityWeatherCard.add(CityWeatherCard(
          temperature: weather.temperature.toInt(),
          weatherIcon: icon,
          cityName: weather.cityName,
          weatherStatus: weather.weatherDescription,
          tempMax: weather.maxTemperature,
          tempMin: weather.minTemperature,
        ));
      } catch (e) {
        continue;
      }
    }
    setState(() {});
  }

  Future<void> _searchCityWeather() async {
    if (cityName == null || cityName!.isEmpty) return;

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => showSpinner = true);

    try {
      final weather = await WeatherViewModel().getCityWeather(cityName ?? '');

      if (weather != null) {
        final condition = weather.weatherId;
        final icon = WeatherViewModel().getWeatherIcon(condition);

        final alreadyExists = cityWeatherCard.any((card) =>
            card.cityName.toLowerCase() == weather.cityName.toLowerCase());

        if (!alreadyExists) {
          setState(() {
            cityWeatherCard.insert(
              0,
              CityWeatherCard(
                temperature: weather.temperature.toInt(),
                weatherIcon: icon,
                cityName: weather.cityName,
                weatherStatus: weather.weatherDescription,
                tempMax: weather.maxTemperature,
                tempMin: weather.minTemperature,
              ),
            );
          });
        }
      } else {
        // handle not found (e.g., show a snackbar)
      }
    } catch (e) {
      print('Search error: $e');
    } finally {
      setState(() => showSpinner = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AbsorbPointer(
        absorbing: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xFF7F999A),
                  Color(0xFFA9A39C),
                ],
              ),
            ),
            child: ModalProgressHUD(
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
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    onChanged: (value) {
                                      cityName = value;
                                    },
                                    onSubmitted: (value) {
                                      _searchCityWeather();
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
                                  onTap: _searchCityWeather,
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
                        onRefresh: () async {},
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

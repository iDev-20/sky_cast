import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/services/time.dart';
import 'package:sky_cast/utilis/constants.dart';
import 'package:sky_cast/utilis/navigation.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key, required this.timeData});

  final Map<String, dynamic> timeData;

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  bool showSpinner = false;

  TimeModel timeModel = TimeModel();
  String? timeZone;
  String? currentTime;

  @override
  void initState() {
    super.initState();
    getTimeForCity(widget.timeData);
  }

  void getTimeForCity(Map<String, dynamic> timeData) async {
    setState(() {
      timeZone = timeData['timeZone'];
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
                                  'Time',
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
                                      timeZone = value;
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
                                    if (timeZone != null) {
                                      var timeData = await timeModel
                                          .getCityTime(timeZone ?? '');
                                      getTimeForCity(timeData);
                                    }
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
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Time Zone: $timeZone',
                                ),
                                Text(
                                  'Current Time: $currentTime',
                                ),
                              ],
                            ),
                          )
                          // ListView.builder(
                          //     padding: const EdgeInsets.only(top: 20.0),
                          //     shrinkWrap: true,
                          //     itemCount: cityWeatherCard.length,
                          //     itemBuilder: (context, index) {
                          //       return cityWeatherCard[index];
                          //     }),
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

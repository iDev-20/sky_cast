import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sky_cast/resources/app_buttons.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/services/time.dart';
import 'package:sky_cast/utilis/constants.dart';
import 'package:sky_cast/utilis/navigation.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  bool showSpinner = false;

  TextEditingController cityController = TextEditingController();
  List<String> continents = [];
  String? selectedContinent;

  @override
  void initState() {
    super.initState();
    loadContinents();
  }

  Future<void> loadContinents() async {
    setState(() {
      showSpinner = true;
    });
    final fetchedContinents = await TimeViewModel().fetchContinents();
    setState(() {
      continents = fetchedContinents;
      selectedContinent =
          fetchedContinents.isNotEmpty ? fetchedContinents.first : 'Error';
      showSpinner = false;
    });
  }

  Future<void> searchTime() async {
    final continent = selectedContinent;
    final city = cityController.text.trim();

    if (continent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a continent')),
      );
      return;
    }

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city')),
      );
      return;
    }

    setState(() {
      showSpinner = true;
    });

    final time = await TimeViewModel().getTimeForTimeZone(
      continent: continent,
      city: city,
    );

    setState(() {
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Color(0xFF7F999A),
                      Color(0xFFA9A39C),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 78, right: 20.0),
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
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0x1FFFFFFF),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      iconSize: 35,
                                      iconEnabledColor: const Color(0xFFD9D9D9),
                                      iconDisabledColor:
                                          const Color(0xFFD9D9D9),
                                      dropdownColor: const Color(0x33000000),
                                      value: selectedContinent,
                                      items: continents
                                          .map(
                                            (continent) => DropdownMenuItem(
                                              value: continent,
                                              child: Text(continent),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) async {
                                        setState(() {
                                          selectedContinent = value ?? '';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: cityController,
                                  cursorColor: const Color(0xFFD9D9D9),
                                  style: const TextStyle(color: Colors.white),
                                  decoration:
                                      kTextFieldInputDecoration.copyWith(
                                    hintStyle: const TextStyle(
                                        color: Color(0xFFD9D9D9)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD9D9D9))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD9D9D9))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD9D9D9))),
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          PrimaryButton(
                            onTap: searchTime,
                            child: const Text('Search'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (showSpinner == true)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

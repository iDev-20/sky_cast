import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sky_cast/resources/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AppImages.rainyBackgroundImage, fit: BoxFit.cover),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 78, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 12),
                              Text(
                                'London, UK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Icon(Icons.menu, color: Colors.white)
                        ],
                      ),
                      const SizedBox(height: 29),
                      const Text(
                        'Today, Oct 18 5:10',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Urbanist'),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: '16',
                                  style: TextStyle(
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
                          RotatedBox(
                            quarterTurns: 3,
                            child: Row(
                              children: [
                                AppImages.svgCloudDrizzle,
                                const Text(
                                  'Mostly Rain',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 82),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 33.0),
                        decoration: BoxDecoration(
                            color: const Color(0x1FFFFFFF),
                            borderRadius: BorderRadius.circular(32)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            row(),
                            line(),
                            row(),
                            line(),
                            row(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 42.0),
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
                        child: hourlyForecast(),
                      ),
                      hourlyForecast(),
                      hourlyForecast(),
                      hourlyForecast(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget row() {
    return const SizedBox(
      child: Column(
        children: [
          Text(
            '23:00',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.0),
          Text(
            'Slight chance \nof rain',
            style: TextStyle(color: Colors.white, fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget line() {
    return Container(
      height: 32,
      width: 1,
      decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(999)),
    );
  }

  Widget hourlyForecast() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 69,
            width: 69,
            decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6), shape: BoxShape.circle),
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
            '23C',
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

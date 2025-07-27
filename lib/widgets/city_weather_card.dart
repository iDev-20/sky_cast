import 'package:flutter/material.dart';
import 'package:sky_cast/resources/app_images.dart';

class CityWeatherCard extends StatelessWidget {
  const CityWeatherCard({
    super.key,
    required this.temperature,
    required this.weatherIcon,
    required this.cityName,
    required this.weatherStatus,
    required this.tempMax,
    required this.tempMin,
  });

  final int temperature;
  final Widget weatherIcon;
  final String cityName;
  final String weatherStatus;
  final double tempMax;
  final double tempMin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
        decoration: BoxDecoration(
          // color: Colors.transparent,
          image: DecorationImage(
            image: AppImages.containerBackgroundImage,
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$temperature',
                        style: const TextStyle(
                            fontFamily: 'Inter_18pt',
                            color: Color(0xFF333333),
                            fontSize: 64,
                            fontWeight: FontWeight.w500),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0.0, 0.0),
                          child: const Text(
                            '°',
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 64,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'H:${tempMax.toStringAsFixed(0)}°  L:${tempMin.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    color: Color(0xFF838383),
                    fontSize: 13,
                  ),
                ),
                Text(
                  cityName,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.5),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF6F6F6), shape: BoxShape.circle),
                  child: weatherIcon,
                ),
                const SizedBox(height: 45.0),
                Text(
                  weatherStatus,
                  style:
                      const TextStyle(color: Color(0xFF333333), fontSize: 13.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

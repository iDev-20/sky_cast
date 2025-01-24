import 'package:flutter/material.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/utilis/constants.dart';
import 'package:sky_cast/utilis/navigation.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
            body: ListView(
              padding: const EdgeInsets.all(0.0),
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
                      SizedBox(
                        height: 36,
                        child: TextField(
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            decoration: kTextFieldInputDecoration),
                      ),
                      const SizedBox(height: 30.0),
                      cityWeather(),
                      cityWeather(),
                      cityWeather(),
                      cityWeather(),
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

  Widget cityWeather() {
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
                      const TextSpan(
                        text: '20',
                        style: TextStyle(
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
                const Text(
                  'H:24°  L:18°',
                  style: TextStyle(
                    color: Color(0xFF838383),
                    fontSize: 13,
                  ),
                ),
                const Text(
                  'Tokyo, Japan',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
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
                  child: AppImages.svgSun,
                ),
                const SizedBox(height: 45.0),
                const Text(
                  'Sunny',
                  style: TextStyle(color: Color(0xFF333333), fontSize: 13.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

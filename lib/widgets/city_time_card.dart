import 'package:flutter/material.dart';
import 'package:sky_cast/resources/app_images.dart';

class CityTimeCard extends StatelessWidget {
  const CityTimeCard({
    super.key,
    required this.time,
    required this.date,
    required this.timeZone,
    required this.day,
  });

  final String time;
  final String date;
  final String timeZone;
  final String day;

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
                Text(
                  time,
                  style: const TextStyle(
                      fontFamily: 'Inter_18pt',
                      color: Color(0xFF333333),
                      fontSize: 64,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 18),
                Text(
                  date,
                  style:
                      const TextStyle(color: Color(0xFF838383), fontSize: 13),
                ),
                const SizedBox(height: 7),
                Text(
                  timeZone,
                  style:
                      const TextStyle(color: Color(0xFF333333), fontSize: 17),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFF6F6F6), shape: BoxShape.circle),
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Image(image: AppImages.earthImage),
                  ),
                ),
                const SizedBox(height: 35),
                Text(day,
                    style: const TextStyle(
                        color: Color(0xFF333333), fontSize: 13.0)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

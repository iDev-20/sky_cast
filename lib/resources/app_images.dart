import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  AppImages._();

  static AssetImage rainyBackgroundImage =
      const AssetImage('assets/images/rainy_background_image.png');
  static AssetImage bottomContainerBackgroundImage =
      const AssetImage('assets/images/bottom_container_background_image.png');
  static AssetImage containerBackgroundImage =
      const AssetImage('assets/images/container_background_image.png');

  static SvgPicture svgCloudDrizzle =
      SvgPicture.asset('assets/svgs/cloud_drizzle.svg');
  static SvgPicture svgCloudDrizzleBlue =
      SvgPicture.asset('assets/svgs/cloud_drizzle_blue.svg');
  static SvgPicture svgCloudLightning =
      SvgPicture.asset('assets/svgs/cloud_lightning.svg');
  static SvgPicture svgCloudSunny =
      SvgPicture.asset('assets/svgs/cloud_sunny.svg');
  static SvgPicture scgDrizzle =
      SvgPicture.asset('assets/svgs/drizzle.svg');
  static SvgPicture svgLocation =
      SvgPicture.asset('assets/svgs/location.svg');
  static SvgPicture svgSunBig =
      SvgPicture.asset('assets/svgs/sun_big.svg');
  static SvgPicture svgSun =
      SvgPicture.asset('assets/svgs/sun.svg');
  static SvgPicture svgWind =
      SvgPicture.asset('assets/svgs/wind.svg');
}

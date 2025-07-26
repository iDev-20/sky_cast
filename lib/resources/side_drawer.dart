import 'package:flutter/material.dart';
import 'package:sky_cast/resources/drawer_menu_items.dart';
import 'package:sky_cast/screens/details_screen.dart';
import 'package:sky_cast/screens/time_screen.dart';
import 'package:sky_cast/utilis/navigation.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  int selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Navigate to:',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Urbanist',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            DrawerMenuItem(
                title: 'Weather',
                icon: Icons.sunny,
                onTap: () {
                  setState(() {
                    selectedDrawerIndex = 1;
                    Navigation.navigateToScreen(
                        context: context, screen: const DetailsScreen());
                  });
                },
                isSelected: selectedDrawerIndex == 1),
            DrawerMenuItem(
                title: 'Time',
                icon: Icons.access_time_filled_rounded,
                onTap: () {
                  selectedDrawerIndex = 2;
                  Navigation.navigateToScreen(
                      context: context, screen: const TimeScreen());
                },
                isSelected: selectedDrawerIndex == 2),
          ],
        ),
      ),
    );
  }
}

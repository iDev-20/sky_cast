import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_cast/utilis/navigation.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    this.visible = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: () {
          Navigation.back(context: context);
          if (!isSelected) {
            onTap.call();
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmallDrawerMenuItem extends StatelessWidget {
  const SmallDrawerMenuItem({
    super.key,
    required this.title,
    required this.titleColor,
    required this.leadingImage,
    required this.onTap,
  });

  final String title;
  final SvgPicture leadingImage;
  final Color titleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            leadingImage,
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, color: titleColor),
            )
          ],
        ),
      ),
    );
  }
}

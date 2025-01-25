import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key, required this.child, this.condition});

  final Widget child;
  final int? condition;

  @override
  Widget build(BuildContext context) {
    return getAppPage(condition ?? 0, child);
  }

  Widget getAppPage(int condition, Widget child) {
    if (condition < 800) {
      return RainyAppPage(child: child);
    } else {
      return SunnyAppPage(child: child);
    }
  }
}

// class AppPage1 {
//   Widget getWeatherIcon(int condition, Widget child) {
//     if (condition < 800) {
//       return RainyAppPage(child: child);
//     } else {
//       return SunnyAppPage(child: child);
//     }
//   }
// }

class SunnyAppPage extends StatelessWidget {
  const SunnyAppPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
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
        body: ModalProgressHUD(inAsyncCall: showSpinner, child: child),
      ),
    );
  }
}

class RainyAppPage extends StatelessWidget {
  const RainyAppPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
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
            body: ModalProgressHUD(inAsyncCall: showSpinner, child: child),
          ),
        ),
      ),
    );
  }
}

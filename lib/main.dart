import 'package:flutter/material.dart';
import 'package:sky_cast/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter_18pt',
        useMaterial3: false,
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey,
      ),
      home: const LoadingScreen(),
    );
  }
}

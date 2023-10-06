import 'package:flutter/material.dart';
import 'package:uts/ui/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Unsoed App CRUD',
      home: SplashScreen(),
    );
  }
}

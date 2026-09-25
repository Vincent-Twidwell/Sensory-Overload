import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const HendrixCardSaverApp());
}

class HendrixCardSaverApp extends StatelessWidget {
  const HendrixCardSaverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Plastic Destroyer',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/career_hub/career_hub_screen.dart';
import 'screens/savings/savings_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/career': (context) => const CareerHubScreen(),
        '/savings': (context) => const SavingsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
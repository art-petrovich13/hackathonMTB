import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Карьерный тренажер'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text(
            'Приложение запущено!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class EarnPointsScreen extends StatelessWidget {
  const EarnPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Способы заработка'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Здесь будет список способов заработка баллов.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

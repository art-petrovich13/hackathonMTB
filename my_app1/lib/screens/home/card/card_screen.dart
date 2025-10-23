import 'package:flutter/material.dart';
import 'widgets/card_header.dart';
import 'widgets/action_buttons_row.dart';
import 'points/points_screen.dart';
import 'widgets/tabs_section.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Кактус BYN', style: TextStyle(color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CardHeader(),
            const SizedBox(height: 18),
            ActionButtonsRow(
              onPointsTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PointsScreen())),
            ),
            const SizedBox(height: 8),
            const TabsSection(),
          ],
        ),
      ),
    );
  }
}

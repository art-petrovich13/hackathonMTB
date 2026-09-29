import 'package:flutter/material.dart';
import '../career_test/career_test_screen.dart';

class CareerHubScreen extends StatelessWidget {
  const CareerHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0D47A1); // Dark blue
    const accentColor = Color(0xFF42A5F5); // Lighter blue

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Карьерный центр', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Карьерный тренажер',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Найди свою идеальную профессию и подготовься к собеседованию',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 40),
              _buildFeatureCard(
                context,
                icon: Icons.quiz_outlined,
                iconColor: accentColor,
                title: 'Пройдите профориентационный тест',
                subtitle: 'Определите свои сильные стороны и подходящие профессии',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CareerTestScreen())),
              ),
              const SizedBox(height: 20),
              _buildFeatureCard(
                context,
                icon: Icons.record_voice_over_outlined,
                iconColor: accentColor,
                title: 'Пройдите симуляцию собеседования',
                subtitle: 'Потренируйтесь на основе результатов теста',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Сначала пройдите профориентационный тест'), duration: Duration(seconds: 2))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required IconData icon, required Color iconColor, required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.blue.shade100, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
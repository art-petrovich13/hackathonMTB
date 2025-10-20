import 'package:flutter/material.dart';
import 'career_test_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карьерный тренажер'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Карьерный тренажер',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Найди свою идеальную профессию и подготовься к собеседованию',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
              const SizedBox(height: 60),
              
              _buildFeatureCard(
                context,
                'Пройдите профориентационный тест',
                'Определите свои сильные стороны и подходящие профессии',
                Icons.quiz_outlined,
                Colors.green,
                () => _navigateToTest(context),
              ),
              
              const SizedBox(height: 20),
              
              _buildFeatureCard(
                context,
                'Пройдите симуляцию собеседования',
                'Потренируйтесь на основе результатов теста',
                Icons.record_voice_over_outlined,
                Colors.orange,
                () => _navigateToInterview(context),
              ),
              
              const SizedBox(height: 20),
              
              _buildFeatureCard(
                context,
                'Узнайте результаты и получите советы',
                'Получите персональные рекомендации по развитию',
                Icons.insights_outlined,
                Colors.purple,
                () => _navigateToResults(context),
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _navigateToTest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Пройти тест',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _navigateToTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CareerTestScreen()),
    );
  }

  void _navigateToInterview(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Сначала пройдите профориентационный тест'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToResults(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Сначала пройдите профориентационный тест'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
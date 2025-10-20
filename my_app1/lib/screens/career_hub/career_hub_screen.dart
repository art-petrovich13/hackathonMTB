import 'package:flutter/material.dart';
import '../career_test/career_test_screen.dart';

class CareerHubScreen extends StatelessWidget {
  const CareerHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карьерный центр'), backgroundColor: Colors.blue[800]),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(decoration: BoxDecoration(color: Colors.blue[800]), child: const Text('Меню', style: TextStyle(color: Colors.white, fontSize: 24))),
              ListTile(leading: const Icon(Icons.home), title: const Text('Главная'), onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)),
              ListTile(leading: const Icon(Icons.work_outline), title: const Text('Карьерный тренажер'), onTap: () => Navigator.pushReplacementNamed(context, '/career')),
              ListTile(leading: const Icon(Icons.savings), title: const Text('Копилка'), onTap: () => Navigator.pushReplacementNamed(context, '/savings')),
              const Spacer(),
              ListTile(leading: const Icon(Icons.settings), title: const Text('Настройки'), onTap: () => Navigator.pushNamed(context, '/settings')),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blue[50]!, Colors.white]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('Карьерный тренажер', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue[900], fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Найди свою идеальную профессию и подготовься к собеседованию', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[700])),
              const SizedBox(height: 60),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.quiz_outlined, color: Colors.green, size: 30),
                  ),
                  title: const Text('Пройдите профориентационный тест'),
                  subtitle: const Text('Определите свои сильные стороны и подходящие профессии'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CareerTestScreen())),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.record_voice_over_outlined, color: Colors.orange, size: 30),
                  ),
                  title: const Text('Пройдите симуляцию собеседования'),
                  subtitle: const Text('Потренируйтесь на основе результатов теста'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Сначала пройдите профориентационный тест'), duration: Duration(seconds: 2))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'earn_points_screen.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example state values; in a real app these would come from a provider/service
    final int currentLevel = 1;
    final double progressBetweenLevels = 0.2; // 0..1 progress from current -> next

    return Scaffold(
      appBar: AppBar(
        title: const Text('Баллы'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro block
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Что такое баллы?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text(
                      'Баллы можно обменять на выгодные услуги, скидки или повышение уровня карты Kopym. Чем выше уровень, тем лучше условия (кешбек, процент годовых и т.д.).',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Levels and progress
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Уровни', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    // Simple horizontal levels indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        final level = index + 1;
                        final isActive = level <= currentLevel;
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: isActive ? const Color(0xFF2E7D32) : Colors.grey.shade300,
                              child: Text('$level', style: const TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(height: 6),
                            Text('Lvl $level', style: TextStyle(fontSize: 12, color: Colors.black54)),
                          ],
                        );
                      }),
                    ),

                    const SizedBox(height: 16),
                    const Text('Прогресс между уровнями', style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: progressBetweenLevels, minHeight: 10),

                    const SizedBox(height: 12),
                    Text('Ваш текущий уровень $currentLevel', style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const Text('1% кешбек и 1% годовых', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // How to earn
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Как можно заработать баллы', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const Text(
                      'Здесь будут перечислены способы заработка баллов (покупки, акции, приглашения и т.д.).',
                      style: TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EarnPointsScreen())),
                          child: const Text('Перейти к способам заработка'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

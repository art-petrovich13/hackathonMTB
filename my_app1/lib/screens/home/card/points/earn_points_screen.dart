import 'package:flutter/material.dart';
import '../../../../quiz/screens/quiz_screen.dart';
import '../../../career_hub/career_hub_screen.dart';

class EarnPointsScreen extends StatelessWidget {
  const EarnPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalPoints = 30; // sample value

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Назад',
        ),
        title: const Text('Способы заработка', style: TextStyle(color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top purple pill with total points
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF6A3BFC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Общие ваши манечки : $totalPoints', style: const TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 18),

            // Intro/description block
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Баллы = развитие', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Text(
                      'Эта система — цикл роста: вы зарабатываете баллы (проекты, сертификаты), которые дают вам уверенность и факты для успешных собеседований, а сам процесс подготовки становится мощным саморазвитием, мотивирующим вас на новые достижения.',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Quiz block
            _buildEarnBlock(
              title: 'Квиз',
              text: 'Пройдите квиз по знанию МТБанка правильно и получите 2 манечки',
              buttonText: 'Пройти квиз',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
              },
            ),

            const SizedBox(height: 12),

            // Prof orientation block
            _buildEarnBlock(
              title: 'Профориентация',
              text: 'Пройдите тест на определение профориентации, который поможет Вам определиться с профессией и получите 3 манечки',
              buttonText: 'Пройти тест',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CareerHubScreen()));
              },
            ),

            const SizedBox(height: 12),

            // Interview block
            _buildEarnBlock(
              title: 'Собеседование',
              text: 'Пройдите эмулятор собеседования на вашу желаемую профессию, который оценит Ваши ответы и поможет чувствовать себя увереннее на реальных собеседованиях и получите 2 манечки',
              buttonText: 'Пройти собеседование',
              onTap: () {
                // Redirecting to Career Hub for interview tools
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CareerHubScreen()));
              },
            ),

            const SizedBox(height: 20),

            // Decorative monster or extra space — can be image, for now a placeholder circle
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
                child: const Center(child: Text('👾', style: TextStyle(fontSize: 36))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarnBlock({required String title, required String text, required String buttonText, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF0D47A1))),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                ),
                onPressed: onTap,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

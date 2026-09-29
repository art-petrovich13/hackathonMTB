import 'package:flutter/material.dart';
import '../../models/test_result.dart';
import '../interview/interview_screen.dart';

class ResultsScreen extends StatelessWidget {
  final TestResult testResult;

  const ResultsScreen({super.key, required this.testResult});

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
        title: const Text('Результаты теста', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, primaryColor),
            const SizedBox(height: 30),
            _buildInfoCard(
              title: 'Описание:',
              icon: Icons.description_outlined,
              iconColor: primaryColor,
              child: Text(
                testResult.description,
                style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              title: 'Рекомендуемые должности:',
              icon: Icons.work_outline,
              iconColor: primaryColor,
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: testResult.recommendedPositions.map((position) {
                  return Chip(
                    label: Text(position, style: const TextStyle(color: primaryColor)),
                    backgroundColor: accentColor.withOpacity(0.1),
                    side: BorderSide(color: accentColor.withOpacity(0.3)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              title: 'Ваши сильные стороны:',
              icon: Icons.check_circle_outline,
              iconColor: accentColor,
              child: Column(
                children: testResult.strengths.map((strength) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.check_circle, color: accentColor),
                    title: Text(strength, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              title: 'Рекомендации по развитию:',
              icon: Icons.lightbulb_outline,
              iconColor: accentColor,
              child: Column(
                children: testResult.improvements.map((improvement) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.arrow_forward, color: accentColor),
                    title: Text(improvement, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterviewScreen(careerField: testResult.careerField, testResult: testResult),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Пройти симуляцию собеседования',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Вернуться на главную', style: TextStyle(color: primaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color primaryColor) {
    const accentColor = Color(0xFF42A5F5);
    return Column(
      children: [
        Text(
          'Ваша сфера: ${testResult.careerField}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: testResult.score,
                  backgroundColor: accentColor.withOpacity(0.2),
                  color: primaryColor,
                  minHeight: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(testResult.score * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Уровень совпадения',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required Widget child,
    IconData? icon,
    Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.blue.shade100, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: iconColor, size: 22),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: iconColor ?? const Color(0xFF0D47A1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
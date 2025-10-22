import 'package:flutter/material.dart';
import 'interview_controller.dart';

class InterviewResults extends StatelessWidget {
  final InterviewController controller;

  const InterviewResults({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final scores = controller.calculateScores();
    final percent = (scores['total']! * 100).clamp(0, 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты собеседования - ${controller.careerField}'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text('🎉 Собеседование завершено!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple)),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: scores['total']! / 100, backgroundColor: Colors.grey[300], color: Colors.purple, minHeight: 10),
                  const SizedBox(height: 8),
                  Text('Итоговая оценка: $percent%', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Краткий разбор ответов:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...controller.questions.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final q = entry.value;
                      final score = scores['perQuestion']![idx] ?? 0.0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${idx + 1}. ${q.question}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(controller.userAnswers[idx].isEmpty ? 'Ответ не предоставлен' : controller.userAnswers[idx], style: TextStyle(color: Colors.grey[700], fontStyle: controller.userAnswers[idx].isEmpty ? FontStyle.italic : FontStyle.normal)),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(value: score, backgroundColor: Colors.grey[200], color: Colors.green, minHeight: 8),
                          const SizedBox(height: 8),
                          if (controller.evaluations.length > idx && controller.evaluations[idx] != null) ...[
                            const SizedBox(height: 6),
                            Text('Комментарий:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text((controller.evaluations[idx]!['feedback'] ?? '').toString(), style: TextStyle(color: Colors.black87)),
                            const SizedBox(height: 8),

                            // Breakdown
                            Row(children: [
                              Expanded(child: Text('Ключи: ${controller.evaluations[idx]!['keywordScore'] ?? 0}%')),
                              Expanded(child: Text('Объём: ${controller.evaluations[idx]!['lengthScore'] ?? 0}%')),
                            ]),
                            const SizedBox(height: 6),
                            Row(children: [
                              Expanded(child: Text('Структура: ${controller.evaluations[idx]!['structureScore'] ?? 0}%')),
                              Expanded(child: Text('Уверенность: ${controller.evaluations[idx]!['confidenceScore'] ?? 0}%')),
                            ]),
                            const SizedBox(height: 8),

                            if (((controller.evaluations[idx]!['missingKeywords']) as List?)?.isNotEmpty ?? false) ...[
                              Text('Рекомендуется добавить: ${((controller.evaluations[idx]!['missingKeywords']) as List).join(', ')}', style: TextStyle(color: Colors.red[700])),
                              const SizedBox(height: 6),
                            ],
                            if (((controller.evaluations[idx]!['matchedKeywords']) as List?)?.isNotEmpty ?? false) ...[
                              Text('Хорошо упомянуто: ${((controller.evaluations[idx]!['matchedKeywords']) as List).join(', ')}', style: TextStyle(color: Colors.green[700])),
                              const SizedBox(height: 6),
                            ],

                            if (((controller.evaluations[idx]!['strengths']) as List?)?.isNotEmpty ?? false) ...[
                              Text('Сильные стороны:', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              ...((controller.evaluations[idx]!['strengths']) as List).map((s) => Text('• $s')).toList(),
                              const SizedBox(height: 8),
                            ],

                            if (((controller.evaluations[idx]!['improvements']) as List?)?.isNotEmpty ?? false) ...[
                              Text('Как улучшить:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800])),
                              const SizedBox(height: 6),
                              ...((controller.evaluations[idx]!['improvements']) as List).map((s) => Text('• $s', style: TextStyle(color: Colors.orange[900]))).toList(),
                              const SizedBox(height: 8),
                            ],

                            if (((controller.evaluations[idx]!['coachTips']) as List?)?.isNotEmpty ?? false) ...[
                              Text('Подсказки от тренера:', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              ...((controller.evaluations[idx]!['coachTips']) as List).map((s) => Text('• $s')).toList(),
                              const SizedBox(height: 8),
                            ],

                            if ((controller.evaluations[idx]!['improvedAnswer'] ?? '').toString().isNotEmpty) ...[
                              Text('Пример улучшенного ответа:', style: TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text((controller.evaluations[idx]!['improvedAnswer'] ?? '').toString(), style: TextStyle(color: Colors.grey[800])),
                              const SizedBox(height: 8),
                            ],
                          ] else ...[
                            const SizedBox(height: 12),
                          ],
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text('Рекомендации для развития:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
            const SizedBox(height: 12),
            ...controller.improvements.entries.map((entry) => Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(entry.key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  const SizedBox(height: 8),
                  ...entry.value.map((impr) => ListTile(leading: const Icon(Icons.arrow_forward, color: Colors.green), title: Text(impr))).toList(),
                ]),
              ),
            )).toList(),

            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: controller.restartInterview, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 16)), child: const Text('Пройти собеседование заново', style: TextStyle(fontSize: 16, color: Colors.white)))),
            const SizedBox(height: 10),
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text('Вернуться на главную'))),
          ],
        ),
      ),
    );
  }
}

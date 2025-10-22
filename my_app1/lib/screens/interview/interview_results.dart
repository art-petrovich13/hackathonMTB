import 'package:flutter/material.dart';
import 'interview_controller.dart';
import '../../services/local_storage.dart';

class InterviewResults extends StatefulWidget {
  final InterviewController controller;

  const InterviewResults({super.key, required this.controller});

  @override
  State<InterviewResults> createState() => _InterviewResultsState();
}

class _InterviewResultsState extends State<InterviewResults> {
  late InterviewController controller;
  Set<String> _completed = {};

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    LocalStorage.loadCompletedImprovements().then((s) {
      setState(() {
        _completed = s;
      });
    });
  }

  void _toggleCompleted(String id) async {
    setState(() {
      if (_completed.contains(id))
        _completed.remove(id);
      else
        _completed.add(id);
    });
    await LocalStorage.saveCompletedImprovements(_completed);
  }

  @override
  Widget build(BuildContext context) {
    final scores = controller.calculateScores();
    // scores['total'] is already a percent (0..100)
    final percent = (scores['total'] as double)
        .clamp(0, 100)
        .toStringAsFixed(0);

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
                  Text(
                    '🎉 Собеседование завершено!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: scores['total']! / 100,
                    backgroundColor: Colors.grey[300],
                    color: Colors.purple,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Итоговая оценка: $percent%',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Aggregated short analysis
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Краткий разбор ответов:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // aggregate missing keywords across evaluations
                    Builder(
                      builder: (_) {
                        final missing = <String>{};
                        for (var ev in controller.evaluations) {
                          if (ev == null) continue;
                          final mk = (ev['missingKeywords'] as List?) ?? [];
                          for (var k in mk) missing.add(k.toString());
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (missing.isNotEmpty) ...[
                              Text(
                                'Часто пропущенные ключевые слова:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: missing
                                    .map((k) => Chip(label: Text(k)))
                                    .toList(),
                              ),
                              const SizedBox(height: 12),
                            ],
                            // per-question details
                            ...controller.questions.asMap().entries.map((
                              entry,
                            ) {
                              final idx = entry.key;
                              final q = entry.value;
                              final score = scores['perQuestion']![idx] ?? 0.0;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${idx + 1}. ${q.question}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    controller.userAnswers[idx].isEmpty
                                        ? 'Ответ не предоставлен'
                                        : controller.userAnswers[idx],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontStyle:
                                          controller.userAnswers[idx].isEmpty
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  LinearProgressIndicator(
                                    value: score,
                                    backgroundColor: Colors.grey[200],
                                    color: Colors.green,
                                    minHeight: 8,
                                  ),
                                  const SizedBox(height: 8),
                                  if (controller.evaluations.length > idx &&
                                      controller.evaluations[idx] != null) ...[
                                    const SizedBox(height: 6),
                                    Text(
                                      'Комментарий:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      (controller.evaluations[idx]!['feedback'] ??
                                              '')
                                          .toString(),
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    const SizedBox(height: 8),

                                    // Breakdown
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Ключи: ${controller.evaluations[idx]!['keywordScore'] ?? 0}%',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Объём: ${controller.evaluations[idx]!['lengthScore'] ?? 0}%',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Структура: ${controller.evaluations[idx]!['structureScore'] ?? 0}%',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Уверенность: ${controller.evaluations[idx]!['confidenceScore'] ?? 0}%',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    if (((controller.evaluations[idx]!['missingKeywords'])
                                                as List?)
                                            ?.isNotEmpty ??
                                        false) ...[
                                      Text(
                                        'Рекомендуется добавить: ${((controller.evaluations[idx]!['missingKeywords']) as List).join(', ')}',
                                        style: TextStyle(
                                          color: Colors.red[700],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                    ],
                                    if (((controller.evaluations[idx]!['matchedKeywords'])
                                                as List?)
                                            ?.isNotEmpty ??
                                        false) ...[
                                      Text(
                                        'Хорошо упомянуто: ${((controller.evaluations[idx]!['matchedKeywords']) as List).join(', ')}',
                                        style: TextStyle(
                                          color: Colors.green[700],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                    ],

                                    if (((controller.evaluations[idx]!['strengths'])
                                                as List?)
                                            ?.isNotEmpty ??
                                        false) ...[
                                      Text(
                                        'Сильные стороны:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      ...((controller
                                                  .evaluations[idx]!['strengths'])
                                              as List)
                                          .map((s) => Text('• $s'))
                                          .toList(),
                                      const SizedBox(height: 8),
                                    ],

                                    if (((controller.evaluations[idx]!['improvements'])
                                                as List?)
                                            ?.isNotEmpty ??
                                        false) ...[
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.report_problem,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Ошибки / недостатки:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      // missing keywords (if any)
                                      if (((controller.evaluations[idx]!['missingKeywords'])
                                                  as List?)
                                              ?.isNotEmpty ??
                                          false) ...[
                                        Text(
                                          'Недостающие ключевые слова: ${((controller.evaluations[idx]!['missingKeywords']) as List).join(', ')}',
                                          style: TextStyle(
                                            color: Colors.red[700],
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                      ],
                                      // improvements with checkbox
                                      ...((controller
                                                  .evaluations[idx]!['improvements'])
                                              as List)
                                          .asMap()
                                          .entries
                                          .map((imEntry) {
                                            final imIdx = imEntry.key;
                                            final imText = imEntry.value
                                                .toString();
                                            final id = 'q${idx}-impr-$imIdx';
                                            final done = _completed.contains(
                                              id,
                                            );
                                            return CheckboxListTile(
                                              value: done,
                                              onChanged: (_) =>
                                                  _toggleCompleted(id),
                                              title: Text(
                                                imText,
                                                style: TextStyle(
                                                  color: done
                                                      ? Colors.grey
                                                      : Colors.orange[900],
                                                  decoration: done
                                                      ? TextDecoration
                                                            .lineThrough
                                                      : TextDecoration.none,
                                                ),
                                              ),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                            );
                                          })
                                          .toList(),
                                      const SizedBox(height: 8),
                                    ],

                                    if (((controller.evaluations[idx]!['coachTips'])
                                                as List?)
                                            ?.isNotEmpty ??
                                        false) ...[
                                      Text(
                                        'Подсказки от тренера:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      ...((controller
                                                  .evaluations[idx]!['coachTips'])
                                              as List)
                                          .map((s) => Text('• $s'))
                                          .toList(),
                                      const SizedBox(height: 8),
                                    ],

                                    if ((controller
                                                .evaluations[idx]!['improvedAnswer'] ??
                                            '')
                                        .toString()
                                        .isNotEmpty) ...[
                                      Text(
                                        'Пример улучшенного ответа:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        (controller.evaluations[idx]!['improvedAnswer'] ??
                                                '')
                                            .toString()
                                            .replaceAll('\n', '\n'),
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ] else ...[
                                    const SizedBox(height: 12),
                                  ],
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Pass probability and resources
            Builder(
              builder: (ctx) {
                final prob = (controller.estimatePassProbability() * 100)
                    .round();
                final label = controller.passCategoryLabel();
                final color = controller.passCategoryColor();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Вероятность прохождения: $prob%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),

            const Text(
              'Рекомендованные ресурсы (за прохождение даются бонусы):',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // resources
            ...controller
                .getRecommendedResources()
                .map(
                  (res) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  res['title'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(res['description'] ?? ''),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '+${res['bonusPoints'] ?? 0} баллов',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 6),
                              ElevatedButton(
                                onPressed: () {
                                  // mock: mark as claimed — in real app we'd call API
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Ресурс "${res['title']}" добавлен в ваши задания',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Добавить'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),

            const SizedBox(height: 12),
            const Text(
              'Рекомендации для развития:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 12),
            ...controller.improvements.entries
                .map(
                  (entry) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...entry.value
                              .map(
                                (impr) => ListTile(
                                  leading: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green,
                                  ),
                                  title: Text(impr),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.restartInterview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Пройти собеседование заново',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Вернуться на главную'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

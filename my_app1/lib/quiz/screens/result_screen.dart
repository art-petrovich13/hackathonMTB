import 'package:flutter/material.dart';
import '../models/quiz_result.dart';
import '../models/question.dart';

class ResultScreen extends StatelessWidget {
  final QuizResult result;
  final List<QuizQuestion> questions;

  const ResultScreen({Key? key, required this.result, required this.questions})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Результаты')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Результат: ${result.correctCount}/${result.total}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/quiz'),
                    child: const Text('Пройти ещё раз'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (result.recommendations.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Рекомендации',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                ...result.recommendations.map(
                  (r) => Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(r),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Детали ответов',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (ctx, i) {
                    final q = questions[i];
                    final user = result.userAnswers[i] ?? [];
                    final correctSet = q.correctIndices.toSet();
                    final userSet = user.toSet();
                    final isCorrect =
                        userSet.isNotEmpty &&
                        userSet.containsAll(correctSet) &&
                        correctSet.containsAll(userSet);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    q.text,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  isCorrect ? Icons.check_circle : Icons.error,
                                  color: isCorrect ? Colors.green : Colors.red,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                // user answers
                                for (var idx = 0; idx < q.options.length; idx++)
                                  Chip(
                                    label: Text(q.options[idx]),
                                    backgroundColor: user.contains(idx)
                                        ? (q.correctIndices.contains(idx)
                                              ? Colors.green.shade100
                                              : Colors.red.shade100)
                                        : null,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (result.perQuestionFeedback.containsKey(i))
                              Text(
                                'Пояснение: ${result.perQuestionFeedback[i]}',
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/test_result.dart';
import 'interview_controller.dart';
import 'interview_chat.dart';
import 'interview_input.dart';
import 'interview_results.dart';

class InterviewScreen extends StatefulWidget {
  final String careerField;
  final TestResult? testResult;

  const InterviewScreen({super.key, required this.careerField, this.testResult});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  late final InterviewController controller;

  @override
  void initState() {
    super.initState();
    controller = InterviewController(careerField: widget.careerField, testResult: widget.testResult);
    // show first question after build
    if (controller.questions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => controller.showInterviewerQuestion());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.interviewCompleted) {
          return InterviewResults(controller: controller);
        }

        if (controller.questions.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Собеседование - ${widget.careerField}'),
              backgroundColor: Colors.orange,
            ),
            body: const Center(
              child: Text('Вопросы для этой сферы не найдены'),
            ),
          );
        }

        final q = controller.questions[controller.currentQuestionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('Собеседование - ${widget.careerField}'),
            backgroundColor: Colors.orange,
            actions: [
              IconButton(
                icon: const Icon(Icons.lightbulb_outline),
                onPressed: controller.toggleTips,
                tooltip: 'Показать подсказки',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (controller.currentQuestionIndex + 1) / controller.questions.length,
                  backgroundColor: Colors.grey[300],
                  color: Colors.orange,
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                InterviewChat(controller: controller),

                if (controller.showTips) ...[
                  Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('💡 Подсказки для ответа:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: q.tips.map((t) => Chip(label: Text(t))).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                InterviewInput(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

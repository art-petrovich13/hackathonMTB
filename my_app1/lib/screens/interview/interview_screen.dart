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
    const primaryColor = Color(0xFF0D47A1);
    const accentColor = Color(0xFF42A5F5);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.interviewCompleted) {
          return InterviewResults(controller: controller);
        }

        if (controller.questions.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _buildAppBar(context, primaryColor),
            body: const Center(
              child: Text('Вопросы для этой сферы не найдены', style: TextStyle(color: primaryColor, fontSize: 16)),
            ),
          );
        }

        final q = controller.questions[controller.currentQuestionIndex];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context, primaryColor, actions: [
            IconButton(
              icon: Icon(controller.showTips ? Icons.lightbulb : Icons.lightbulb_outline, color: primaryColor),
              onPressed: controller.toggleTips,
              tooltip: 'Показать подсказки',
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (controller.currentQuestionIndex + 1) / controller.questions.length,
                  backgroundColor: accentColor.withOpacity(0.2),
                  color: primaryColor,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Expanded(child: InterviewChat(controller: controller)),
                if (controller.showTips) ...[
                  const SizedBox(height: 8),
                  Card(
                    elevation: 1,
                    color: primaryColor.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.blue.shade100, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('💡 Подсказки для ответа:', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: 16)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: q.tips.map((tip) {
                              return Chip(
                                label: Text(tip, style: const TextStyle(color: primaryColor)),
                                backgroundColor: accentColor.withOpacity(0.1),
                                side: BorderSide(color: accentColor.withOpacity(0.3)),
                              );
                            }).toList(),
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

  AppBar _buildAppBar(BuildContext context, Color primaryColor, {List<Widget>? actions}) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Собеседование - ${widget.careerField}',
        style: const TextStyle( fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: actions,
    );
  }
}

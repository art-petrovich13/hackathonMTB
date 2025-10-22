import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../services/quiz_service.dart';
import '../models/question.dart';
import '../widgets/question_widget.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final int variant;
  const QuizScreen({Key? key, this.variant = 1}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _service = QuizService();
  late final List<QuizQuestion> _questions;
  final Map<int, List<int>> _answers = {};
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _questions = _service.loadVariant(widget.variant);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onAnswer(int index, List<int> selected) {
    _answers[index] = selected;
    setState(() {});
  }

  void _goNext(int index) {
    if (index < _questions.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final result = _service.evaluate(_questions, _answers);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ResultScreen(result: result, questions: _questions)));
    }
  }

  bool _answered(int index) {
    final list = _answers[index];
    return list != null && list.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Квиз МТБанк')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.school, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  const Text('Финансовая грамотность — МТБанк', style: TextStyle(fontWeight: FontWeight.w600)),
                  const Spacer(),
                ],
              ),
            ),
            // progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ValueListenableBuilder<double>(
                valueListenable: ValueNotifier(0.0),
                builder: (_, __, ___) {
                  return LinearProgressIndicator(
                    value: (_answers.length) / _questions.length,
                    minHeight: 6,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: _questions.length,
                onPageChanged: (_) => setState(() {}),
                itemBuilder: (context, index) {
                  final q = _questions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Вопрос ${index + 1} из ${_questions.length}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: SingleChildScrollView(
                            child: QuestionWidget(
                              question: q,
                              onAnswer: (selected) => _onAnswer(index, selected),
                              // show previously selected if present
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _answered(index) ? () => _goNext(index) : null,
                                child: Text(index == _questions.length - 1 ? 'Завершить' : 'Далее'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // no inline popups here — results and recommendations are shown on the results screen
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

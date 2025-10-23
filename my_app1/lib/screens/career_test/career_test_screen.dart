import 'package:flutter/material.dart';
import '../../services/test_service.dart';
import '../results/results_screen.dart';

class CareerTestScreen extends StatefulWidget {
  const CareerTestScreen({super.key});

  @override
  State<CareerTestScreen> createState() => _CareerTestScreenState();
}

class _CareerTestScreenState extends State<CareerTestScreen> {
  int _currentQuestionIndex = 0;
  List<int?> _answers = List.filled(TestService.questions.length, null);
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _updateProgress();
  }

  void _updateProgress() {
    setState(() {
      _progress = _currentQuestionIndex / TestService.questions.length;
    });
  }

  void _answerQuestion(int answerIndex) {
    setState(() {
      _answers[_currentQuestionIndex] = answerIndex;
    });

    if (_currentQuestionIndex < TestService.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _updateProgress();
      });
    } else {
      _completeTest();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _updateProgress();
      });
    }
  }

  void _completeTest() {
    if (_answers.any((answer) => answer == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, ответьте на все вопросы')),
      );
      return;
    }

    final result = TestService.calculateResult(_answers.cast<int>());
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(testResult: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = TestService.questions[_currentQuestionIndex];
    const primaryBlue = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Профориентационный тест'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: primaryBlue),
        titleTextStyle: const TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.w600),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primaryBlue,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: const Color(0xFFE3F2FD),
              color: primaryBlue,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 20),
            
            Text(
              'Вопрос ${_currentQuestionIndex + 1} из ${TestService.questions.length}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF607D8B),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            
            Text(
              currentQuestion.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 30),
            
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        currentQuestion.options[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: _answers[_currentQuestionIndex] == index
                          ? const Icon(Icons.check_circle, color: primaryBlue)
                          : null,
                      onTap: () => _answerQuestion(index),
                    ),
                  );
                },
              ),
            ),
            
            Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousQuestion,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryBlue,
                        side: const BorderSide(color: primaryBlue),
                      ),
                      child: const Text('Назад'),
                    ),
                  ),
                if (_currentQuestionIndex > 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentQuestionIndex == TestService.questions.length - 1
                        ? _completeTest
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                    ),
                    child: Text(
                      _currentQuestionIndex == TestService.questions.length - 1
                          ? 'Завершить тест'
                          : 'Следующий вопрос',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

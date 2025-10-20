import 'package:flutter/material.dart';
import '../../models/interview_question.dart';
import 'interview_service.dart';

class InterviewScreen extends StatefulWidget {
  final String careerField;

  const InterviewScreen({super.key, required this.careerField});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  int _currentQuestionIndex = 0;
  List<InterviewQuestion> _questions = [];
  List<String> _userAnswers = [];
  bool _showTips = false;
  bool _interviewCompleted = false;
  Map<String, List<String>> _improvements = {};

  @override
  void initState() {
    super.initState();
    _questions = InterviewService.getInterviewQuestions()[widget.careerField] ?? [];
    _userAnswers = List.filled(_questions.length, '');
    _improvements = InterviewService.getCareerImprovements()[widget.careerField] ?? {};
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showTips = false;
      });
    } else {
      _completeInterview();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _showTips = false;
      });
    }
  }

  void _completeInterview() {
    setState(() {
      _interviewCompleted = true;
    });
  }

  void _restartInterview() {
    setState(() {
      _currentQuestionIndex = 0;
      _userAnswers = List.filled(_questions.length, '');
      _showTips = false;
      _interviewCompleted = false;
    });
  }

  void _toggleTips() {
    setState(() {
      _showTips = !_showTips;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_interviewCompleted) {
      return _buildResultsScreen();
    }

    if (_questions.isEmpty) {
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

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Собеседование - ${widget.careerField}'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: _toggleTips,
            tooltip: 'Показать подсказки',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Прогресс
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.orange,
              minHeight: 8,
            ),
            const SizedBox(height: 20),
            
            // Номер вопроса и категория
            Row(
              children: [
                Text(
                  'Вопрос ${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Chip(
                  label: Text(currentQuestion.category),
                  backgroundColor: Colors.orange.withOpacity(0.1),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Вопрос
            Text(
              currentQuestion.question,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            
            // Подсказки
            if (_showTips) ...[
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💡 Подсказки для ответа:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...currentQuestion.tips.map((tip) => 
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '),
                              Expanded(child: Text(tip)),
                            ],
                          ),
                        )
                      ).toList(),
                      const SizedBox(height: 10),
                      const Text(
                        'Ключевые слова для упоминания:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        children: currentQuestion.keywords.map((keyword) => 
                          Chip(
                            label: Text(keyword),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            labelStyle: const TextStyle(fontSize: 12),
                          )
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
            
            // Поле для ответа
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Введите ваш ответ здесь...',
                        border: const OutlineInputBorder(),
                        labelText: 'Ваш ответ',
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _userAnswers[_currentQuestionIndex] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Идеальный ответ (по желанию)
                    ExpansionTile(
                      title: const Text('Посмотреть пример идеального ответа'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            currentQuestion.idealAnswer,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Кнопки навигации
            Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousQuestion,
                      child: const Text('Назад'),
                    ),
                  ),
                if (_currentQuestionIndex > 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _userAnswers[_currentQuestionIndex].trim().isNotEmpty
                        ? _nextQuestion
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      _currentQuestionIndex == _questions.length - 1
                          ? 'Завершить собеседование'
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

  Widget _buildResultsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты собеседования - ${widget.careerField}'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '🎉 Собеседование завершено!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ваши ответы:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._questions.asMap().entries.map((entry) => 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.key + 1}. ${entry.value.question}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _userAnswers[entry.key].isEmpty ? 
                            'Ответ не предоставлен' : _userAnswers[entry.key],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontStyle: _userAnswers[entry.key].isEmpty ? 
                                FontStyle.italic : FontStyle.normal,
                            ),
                          ),
                          const Divider(),
                        ],
                      )
                    ).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Рекомендации по улучшению
            const Text(
              'Рекомендации для развития:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            
            ..._improvements.entries.map((entry) => 
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...entry.value.map((improvement) => 
                        ListTile(
                          leading: const Icon(Icons.arrow_forward, color: Colors.green),
                          title: Text(improvement),
                          minLeadingWidth: 0,
                        )
                      ).toList(),
                    ],
                  ),
                ),
              )
            ).toList(),
            
            const SizedBox(height: 30),
            
            // Кнопки действий
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _restartInterview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Пройти собеседование заново',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    child: const Text('Вернуться на главную'),
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

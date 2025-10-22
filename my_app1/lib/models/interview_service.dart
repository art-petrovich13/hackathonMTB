// lib/services/interview_service.dart
import '../models/test_result.dart';

// Класс вопроса собеседования
class CareerInterviewQuestion {
  final String id;
  final String question;
  final String category;
  final List<String> tips;
  final String idealAnswer;
  final List<String> keywords;
  final List<String> targetFields;

  const CareerInterviewQuestion({
    required this.id,
    required this.question,
    required this.category,
    required this.tips,
    required this.idealAnswer,
    required this.keywords,
    required this.targetFields,
  });
}

class InterviewService {
  static final List<CareerInterviewQuestion> allQuestions = [
    CareerInterviewQuestion(
      id: 'it_1',
      question: 'Расскажите о своем опыте в программировании и какие технологии вы использовали?',
      category: 'Технические навыки',
      tips: [
        'Упомяните конкретные языки программирования',
        'Расскажите о реальных проектах',
        'Опишите свой уровень владения технологиями'
      ],
      idealAnswer: 'Я имею опыт работы с различными технологиями в течение нескольких лет. Разрабатывал(а) проекты, где использовались технологии такие как JavaScript, Python, React, базы данных, Git, API.',
      keywords: ['JavaScript', 'Python', 'React', 'базы данных', 'Git', 'API', 'проекты'],
      targetFields: ['tech', 'creative'],
    ),
    CareerInterviewQuestion(
      id: 'it_2',
      question: 'Как вы подходите к решению сложных технических проблем?',
      category: 'Решение проблем',
      tips: [
        'Опишите свой процесс анализа',
        'Упомяните отладку и тестирование',
        'Расскажите о работе в команде'
      ],
      idealAnswer: 'Сначала анализирую проблему и воспроизвожу ее. Использую логирование и отладку для диагностики. Создаю план решения, тестирую гипотезы и документирую процесс.',
      keywords: ['анализ', 'отладка', 'тестирование', 'документация', 'решение'],
      targetFields: ['tech', 'management'],
    ),
    CareerInterviewQuestion(
      id: 'creative_1',
      question: 'Опишите ваш творческий процесс при работе над новым проектом?',
      category: 'Креативность',
      tips: [
        'Расскажите о этапах разработки',
        'Упомяните источники вдохновения',
        'Опишите работу с обратной связью'
      ],
      idealAnswer: 'Начинаю с исследования и сбора референсов. Затем создаю мудборд и несколько концепций. После утверждения концепции разрабатываю детальный дизайн.',
      keywords: ['исследование', 'концепции', 'дизайн', 'обратная связь'],
      targetFields: ['creative'],
    ),
    CareerInterviewQuestion(
      id: 'social_1',
      question: 'Как вы выстраиваете эффективное общение в команде?',
      category: 'Коммуникация',
      tips: [
        'Упомяните методы коммуникации',
        'Расскажите о решении конфликтов',
        'Опишите работу с разными типами личности'
      ],
      idealAnswer: 'Использую регулярные встречи, четкую документацию и открытые каналы коммуникации. Стараюсь понять стиль работы каждого члена команды и адаптировать подход.',
      keywords: ['команда', 'коммуникация', 'конфликты', 'медиация'],
      targetFields: ['social', 'management'],
    ),
    CareerInterviewQuestion(
      id: 'management_1',
      question: 'Как вы оцениваете эффективность маркетинговой кампании?',
      category: 'Аналитика',
      tips: [
        'Упомяните ключевые метрики',
        'Расскажите об инструментах аналитики',
        'Опишите процесс оптимизации'
      ],
      idealAnswer: 'Оцениваю по ключевым метрикам: ROI, CTR, конверсия, стоимость привлечения клиента. Использую Google Analytics, CRM-системы.',
      keywords: ['ROI', 'CTR', 'конверсия', 'аналитика', 'оптимизация'],
      targetFields: ['management', 'social'],
    ),
  ];

  static List<CareerInterviewQuestion> getQuestionsForField(String field) {
    return allQuestions.where((question) {
      return question.targetFields.contains(field);
    }).toList();
  }

  static List<CareerInterviewQuestion> getPersonalizedQuestions(TestResult testResult) {
    List<CareerInterviewQuestion> questions = [];
    
    if (testResult.careerField.contains('IT') || testResult.careerField.contains('Технические')) {
      questions.addAll(getQuestionsForField('tech'));
    }
    if (testResult.careerField.contains('Творчество') || testResult.careerField.contains('Дизайн')) {
      questions.addAll(getQuestionsForField('creative'));
    }
    if (testResult.careerField.contains('Коммуникации') || testResult.careerField.contains('Работа с людьми')) {
      questions.addAll(getQuestionsForField('social'));
    }
    if (testResult.careerField.contains('Управление') || testResult.careerField.contains('Бизнес')) {
      questions.addAll(getQuestionsForField('management'));
    }

    if (questions.length < 3) {
      questions.addAll(getQuestionsForField('social'));
      questions.addAll(getQuestionsForField('management'));
    }

    questions.shuffle();
    return questions.take(5).toList();
  }
  
  /// Recommended learning resources (books/courses) per field.
  /// Each resource: title, type, description, bonusPoints
  static Map<String, List<Map<String, dynamic>>> getRecommendedResources() {
    return {
      'IT и Технологии': [
        {
          'title': 'Алгоритмы и структуры данных — курс',
          'type': 'course',
          'description': 'Практический курс по алгоритмам с задачами и проектом.',
          'bonusPoints': 10,
        },
        {
          'title': 'Книга: Чистый код',
          'type': 'book',
          'description': 'Классика по качественному написанию кода и архитектуре.',
          'bonusPoints': 5,
        },
        {
          'title': 'Практика DevOps: CI/CD',
          'type': 'course',
          'description': 'Курс по настройке CI/CD, контейнеризации и автоматизации.',
          'bonusPoints': 8,
        },
      ],
    };
  }

  static Map<String, dynamic> evaluateAnswer(String userAnswer, CareerInterviewQuestion question) {
    // Normalize and enrich evaluation
    final text = userAnswer.trim();
    final words = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;

    // Keyword matching
    final matchedKeywords = <String>[];
    final missingKeywords = <String>[];
    for (final keyword in question.keywords) {
      if (text.toLowerCase().contains(keyword.toLowerCase())) {
        matchedKeywords.add(keyword);
      } else {
        missingKeywords.add(keyword);
      }
    }

    final keywordScore = question.keywords.isEmpty
        ? 0.0
        : (matchedKeywords.length / question.keywords.length).clamp(0.0, 1.0);

    // Length/coverage score (prefers substantive answers, penalizes overly short replies)
    final lengthScore = (words / 30).clamp(0.0, 1.0);

    // Structure score: look for presence of example words like "пример", "например", «ситуация», or use of past tense verbs
    double structureScore = 0.0;
    final structureHints = ['пример', 'например', 'когда', 'в проекте', 'в задаче', 'достиг', 'решил'];
    for (final h in structureHints) {
      if (text.toLowerCase().contains(h)) {
        structureScore = 1.0;
        break;
      }
    }

    // Confidence / tone: simple heuristic using exclamation or confident phrases
    double confidenceScore = 0.0;
    final confHints = ['я уверен', 'я могу', 'я сделал', 'могу предложить', 'я достиг'];
    for (final h in confHints) {
      if (text.toLowerCase().contains(h)) {
        confidenceScore = 1.0;
        break;
      }
    }

    // Combine into normalized score (0..100)
    final combined = (keywordScore * 0.5 + lengthScore * 0.25 + structureScore * 0.15 + confidenceScore * 0.1).clamp(0.0, 1.0);
    final score = (combined * 100).round();

    // Build actionable feedback
    final strengths = <String>[];
    final improvements = <String>[];

    if (keywordScore > 0.6) strengths.add('Вы упомянули ключевые термины, релевантные вопросу.');
    if (structureScore > 0.0) strengths.add('Ответ содержит конкретный пример/ситуацию.');
    if (confidenceScore > 0.0) strengths.add('Тон ответа выглядит уверенным.');
    if (lengthScore > 0.6) strengths.add('Объем ответа достаточен для раскрытия темы.');

    if (keywordScore < 0.5 && question.keywords.isNotEmpty) improvements.add('Упомяните релевантные ключевые слова: ${missingKeywords.join(', ')}.');
    if (structureScore == 0.0) improvements.add('Добавьте конкретный пример или ситуацию (Context → Action → Result).');
    if (lengthScore < 0.4) improvements.add('Расширьте ответ: опишите конкретный пример, ваши действия и результат.');
    if (confidenceScore == 0.0) improvements.add('Используйте уверенные формулировки и глаголы действия ("я сделал", "я достиг").');

    // Produce an improvedAnswer template based on idealAnswer and missing keywords
    String improvedAnswer = question.idealAnswer;
    if (missingKeywords.isNotEmpty) {
      improvedAnswer += '\nРекомендуется упомянуть: ${missingKeywords.join(', ')}.';
    }

    // Short coach message with exact suggestions how to answer
    final coachTips = <String>[];
    coachTips.add('Структура ответа: 1) Контекст — кратко опишите ситуацию; 2) Действие — что вы сделали; 3) Результат — что достигли (цифры/эффект).');
    if (missingKeywords.isNotEmpty) coachTips.add('Включите в ответ ключевые слова: ${missingKeywords.join(', ')}.');
    coachTips.add('Держите ответ чётким: 2–4 предложения + 1 пример (если возможно).');

    String feedback = '';
    if (score >= 80) feedback = 'Отличный ответ: вы дали структурированный и содержательный ответ.';
    else if (score >= 60) feedback = 'Хороший ответ, но его можно усилить конкретными примерами и ключевыми словами.';
    else if (score >= 40) feedback = 'Ответ средний: добавьте примеры и ключевые термины, опишите результат ваших действий.';
    else feedback = 'Ответ слабый: добавьте структуру (Context → Action → Result), конкретные примеры и ключевые слова.';

    return {
      'score': score.clamp(0, 100),
      'keywordScore': (keywordScore * 100).round(),
      'lengthScore': (lengthScore * 100).round(),
      'structureScore': (structureScore * 100).round(),
      'confidenceScore': (confidenceScore * 100).round(),
      'matchedKeywords': matchedKeywords,
      'missingKeywords': missingKeywords,
      'strengths': strengths,
      'improvements': improvements,
      'feedback': feedback,
      'coachTips': coachTips,
      'improvedAnswer': improvedAnswer,
      'idealAnswer': question.idealAnswer,
    };
  }
}
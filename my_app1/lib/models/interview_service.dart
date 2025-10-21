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

  static Map<String, dynamic> evaluateAnswer(String userAnswer, CareerInterviewQuestion question) {
    int score = 0;
    List<String> matchedKeywords = [];
    List<String> missingKeywords = [];
    String feedback = '';

    for (String keyword in question.keywords) {
      if (userAnswer.toLowerCase().contains(keyword.toLowerCase())) {
        score += 10;
        matchedKeywords.add(keyword);
      } else {
        missingKeywords.add(keyword);
      }
    }

    if (userAnswer.length > 100) score += 20;
    else if (userAnswer.length > 50) score += 10;

    if (score >= 60) {
      feedback = 'Отличный ответ! Вы хорошо раскрыли тему и использовали ключевые аспекты.';
    } else if (score >= 40) {
      feedback = 'Хороший ответ, но можно добавить больше деталей и примеров.';
    } else {
      feedback = 'Ответ слишком краткий. Попробуйте добавить конкретные примеры и детали.';
    }

    if (missingKeywords.isNotEmpty) {
      feedback += '\n\nРекомендуется упомянуть: ${missingKeywords.join(', ')}';
    }

    return {
      'score': score.clamp(0, 100),
      'matchedKeywords': matchedKeywords,
      'missingKeywords': missingKeywords,
      'feedback': feedback,
      'idealAnswer': question.idealAnswer,
    };
  }
}
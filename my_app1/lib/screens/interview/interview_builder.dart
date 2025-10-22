import '../../models/test_result.dart';
import '../../models/interview_question.dart';

/// Builds a tailored list of InterviewQuestion based on TestResult from the
/// prof-orientation test. The builder produces a balanced interview with
/// technical, behavioral, situational and career-motivation questions.
class InterviewBuilder {
  static List<InterviewQuestion> buildFromTestResult(TestResult result) {
    final questions = <InterviewQuestion>[];

    // Intro / ice-breaker
    questions.add(InterviewQuestion(
      id: 'intro',
      question: 'Расскажите кратко о себе и о том, почему вы заинтересованы в роли: ${result.careerField}.',
      category: 'Вступление',
      tips: ['Коротко о релевантном опыте', 'Свяжите мотивацию с позицией/сферой'],
      idealAnswer: 'Коротко описать профессиональный путь, ключевые навыки и почему данная сфера/должность интересна.',
      keywords: [result.careerField],
    ));

    // Technical / role-specific questions based on recommended positions
    for (var i = 0; i < result.recommendedPositions.length && i < 3; i++) {
      final pos = result.recommendedPositions[i];
      questions.add(InterviewQuestion(
        id: 'role_$i',
        question: 'Какие ключевые компетенции, по вашему мнению, требуются для должности "$pos" и как вы соответствуете этим требованиям?',
        category: 'Профессиональные навыки',
        tips: ['Опишите конкретные навыки и опыт', 'Приведите примеры из практики'],
        idealAnswer: 'Перечислите ключевые компетенции и свяжите их с вашим опытом, упомяните достижения/проекты.',
        keywords: pos.split(' ').take(3).toList(),
      ));
    }

    // Behavioral questions focusing on strengths and improvements
    questions.add(InterviewQuestion(
      id: 'strengths',
      question: 'Назовите 2–3 ваших сильных стороны и приведите пример, когда они помогли добиться результата.',
      category: 'Soft Skills',
      tips: ['Сформулируйте сильные стороны чётко', 'Подкрепите примером с цифрами, если возможно'],
      idealAnswer: 'Кратко перечислите сильные стороны и один-два конкретных примера их применения.',
      keywords: result.strengths.take(4).toList(),
    ));

    questions.add(InterviewQuestion(
      id: 'weakness',
      question: 'Какие направления вы пока считаете зонами роста и какие шаги предпринимаете для их развития?',
      category: 'Развитие',
      tips: ['Будьте честны, опишите план развития', 'Покажите готовность учиться'],
      idealAnswer: 'Опишите реальную зону роста и конкретные шаги/курсы/проекты для её улучшения.',
      keywords: result.improvements.take(4).toList(),
    ));

    // Situational / scenario-based
    questions.add(InterviewQuestion(
      id: 'situation',
      question: 'Опишите ситуацию, когда вам пришлось работать в сжатые сроки и приоритеты менялись. Как вы действовали?',
      category: 'Ситуационные задачи',
      tips: ['Опишите контекст, ваше действие и результат', 'Укажите как вы расставляли приоритеты'],
      idealAnswer: 'Краткое описание ситуации, действий и достигнутого результата, с упором на приоритеты и коммуникацию.',
      keywords: ['приоритет', 'сроки', 'коммуникация', 'результат'],
    ));

    // Motivation / Career goals
    questions.add(InterviewQuestion(
      id: 'goals',
      question: 'Куда вы видите себя через 2–3 года и какие шаги планируете для достижения этой цели?',
      category: 'Мотивация',
      tips: ['Покажите связность между текущим опытом и целями', 'Опишите конкретные шаги'],
      idealAnswer: 'Четкие карьерные цели и конкретный план действий для их достижения.',
      keywords: result.nextSteps.take(4).toList(),
    ));

    // Final wrap-up
    questions.add(InterviewQuestion(
      id: 'closing',
      question: 'Есть ли у вас вопросы к нам и что бы вы хотели добавить о своём опыте?',
      category: 'Завершение',
      tips: ['Подготовьте 1–2 вопроса о команде/проектах', 'Коротко подчеркните релевантный опыт'],
      idealAnswer: 'Пара целенаправленных вопросов об ожиданиях и условиях, краткая сильная мысль в конце.',
      keywords: [],
    ));

    return questions;
  }
}

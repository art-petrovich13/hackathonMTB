import '../models/question.dart';
import '../models/quiz_result.dart';

class QuizService {
  // Two variants: 1 and 2
  List<QuizQuestion> loadVariant(int variant) {
    if (variant == 2) return _variantTwo();
    return _variantOne();
  }

  List<QuizQuestion> _variantOne() {
    return [
      QuizQuestion(
        id: 'q1',
        text: 'Какие формы денег бывают?',
        options: [
          'Наличные и безналичные',
          'Наличные, безналичные, электронные',
          'Наличные и электронные',
          'Наличные, счет в банке, карточка в банке, электронный кошелек',
        ],
        correctIndices: [1, 3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q2',
        text: 'В чем преимущество безналичных денег перед наличными?',
        options: [
          'Они не изнашиваются со временем',
          'Ими невозможно воспользоваться мошенникам',
          'Они могут быть удобнее в расчетах',
        ],
        correctIndices: [2],
      ),
      QuizQuestion(
        id: 'q3',
        text: 'Какие источники доходов Вы знаете?',
        options: [
          'Доходы от активов',
          'Доходы от пассивов',
          'Доходы от текущей деятельности',
          'Социальные доходы',
        ],
        correctIndices: [0,2,3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q4',
        text: 'Выбери необходимые расходы?',
        options: [
          'Квартплата за квартиру, где ты живешь',
          'Помощь бабушке и дедушке',
          'Оплата налогов',
          'Расходы на покупку ценных бумаг',
        ],
        correctIndices: [0,2],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q5',
        text: 'Какие достоинства есть у накопления на цель по сравнению с тем, чтобы одолжить?',
        options: [
          'Нет необходимости регулярно с точностью до дня делать платежи',
          'Как правило, ничего страшного не случится, если пропустить один платеж',
          'Цель гарантированно будет достигнута',
          'Ты никак не зависишь от инфляции',
        ],
        correctIndices: [0,1],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q6',
        text: 'Какие недостатки есть у депозитов?',
        options: [
          'Невысокая доходность',
          'Риск потерять все сбережения',
          'Иногда – невозможность изъять всю сумму до окончания срока вклада',
          'Невозможность открыть депозит в какой-то другой валюте, кроме рублей',
        ],
        correctIndices: [0,2],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q7',
        text: 'Какие достоинства есть у облигаций?',
        options: [
          'Гарантированный доход (в случае надежности того, кто выпустил облигацию)',
          'Возможность существенно приумножить свои сбережения',
          'Гарантия сохранности средств даже при банкротстве компании, выпустившей облигацию',
          'Возможность иметь регулярный доход',
        ],
        correctIndices: [0,3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q8',
        text: 'Какие достоинства есть у акций?',
        options: [
          'Возможность принести существенный доход',
          'Возможность регулярного дохода',
          'Гарантированная доходность',
          'Страхование на случай банкротства компании, выпустившей акции',
        ],
        correctIndices: [0,1],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q9',
        text: 'На что в большей степени влияет твоя кредитная история?',
        options: [
          'На возможность в дальнейшем брать кредиты',
          'На условия предоставления тебе кредитов',
          'На подходящий тебе вид кредитов',
          'На размер и срок кредита, который тебе предоставят',
        ],
        correctIndices: [0,1,3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q10',
        text: 'Какой финансовый инструмент тебе подойдет, если у тебя нестабильные доходы?',
        options: [
          'Кредит',
          'Депозит',
          'Акции',
          'Облигации',
        ],
        correctIndices: [1,3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q11',
        text: 'Какой инструмент тебе подойдет, чтобы купить мобильный телефон через 6 мес., новые мобильные телефоны появляются каждый месяц?',
        options: [
          'Кредит',
          'Депозит',
          'Акции',
          'Облигации',
        ],
        correctIndices: [0,1],
        multiple: true,
      ),
      QuizQuestion(
        id: 'q12',
        text: 'Что нужно знать, чтобы грамотно управлять своими финансами?',
        options: [
          'Свои цели',
          'Свои доходы, расходы, накопления, кредиты и т.д.',
          'Финансовые инструменты',
          'Методику составления личного финансового плана',
        ],
        correctIndices: [0,1,2,3],
        multiple: true,
      ),
    ];
  }

  List<QuizQuestion> _variantTwo() {
    return [
      QuizQuestion(
        id: 'v2q1',
        text: 'Какая форма денег может быть опасна из-за мошенничества в интернете?',
        options: [
          'Наличные и безналичные',
          'Безналичные (счет в банке и карта в банке)',
          'Безналичные (электронный кошелек)',
        ],
        correctIndices: [1,2],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q2',
        text: 'Если у Вас есть банковская карточка, то что это означает?',
        options: [
          'У него точно есть электронный кошелек',
          'У него есть счет в банке',
          'a, b',
          'Ничего из вышеперечисленного',
        ],
        correctIndices: [1,2],
      ),
      QuizQuestion(
        id: 'v2q3',
        text: 'В чем преимущество доходов от активов?',
        options: [
          'Они не зависят от твоей способности работать',
          'Они помогают подстраховаться на случай увольнения',
          'Они обеспечиваются государством',
        ],
        correctIndices: [0,1],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q4',
        text: 'Какие недостатки есть у накопления на цель по сравнению с тем, чтобы одолжить?',
        options: [
          'Тебе придется дольше ждать реализации цели',
          'Ты серьезно рискуешь, если пропустишь очередной платеж',
          'Требует самодисциплины',
          'Требует безупречной репутации',
        ],
        correctIndices: [0,2],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q5',
        text: 'Какие достоинства есть у депозита?',
        options: [
          'Гарантированный доход',
          'Возможность существенно приумножить свои сбережения',
          'Гарантия сохранности средств даже при банкротстве банка',
          'Возможность иметь регулярный доход, не снимая сбережений',
        ],
        correctIndices: [0,3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q6',
        text: 'Какие недостатки есть у облигаций?',
        options: [
          'Не слишком высокая доходность',
          'В худшем случае - риск потерять все сбережения',
          'Невозможность продать облигацию до истечения ее срока',
        ],
        correctIndices: [0,1],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q7',
        text: 'Какие недостатки есть у акций?',
        options: [
          'Не слишком высокая доходность',
          'В худшем случае - риск потерять все сбережения',
          'Невозможность продать акцию до истечения ее срока',
        ],
        correctIndices: [1],
      ),
      QuizQuestion(
        id: 'v2q8',
        text: 'Какие параметры кредита нужно менять, чтобы изменить ежемесячный платеж?',
        options: [
          'Валюту',
          'Кредитную историю',
          'Срок',
          'Сумму',
        ],
        correctIndices: [2,3],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q9',
        text: 'Какой инструмент тебе подойдет, чтобы через 3 мес. оплатить быстро дорожающий образовательный курс, который ты не можешь отложить?',
        options: [
          'Кредит',
          'Депозит',
          'Акции',
          'Облигации',
        ],
        correctIndices: [0],
      ),
      QuizQuestion(
        id: 'v2q10',
        text: 'Какова дальнейшая работа с личным финансовым планом?',
        options: [
          'Ему следуют без изменений',
          'Он периодически корректируется',
          'Он каждый год создается заново',
          'Он не меняется в течение жизни',
        ],
        correctIndices: [1],
      ),
      QuizQuestion(
        id: 'v2q11',
        text: 'В чем преимущество личного финансового плана перед спонтанным подходом?',
        options: [
          'Он позволяет оценить текущую финансовую ситуацию, улучшить ее.',
          'Он позволяет подобрать подходящие финансовые инструменты с учетом всех целей',
          'Он позволяет учесть все финансовые цели семьи',
          'Он позволяет гарантированно достичь всех желаемых целей.',
        ],
        correctIndices: [0,1,2],
        multiple: true,
      ),
      QuizQuestion(
        id: 'v2q12',
        text: 'На какой срок составляется личный финансовый план?',
        options: ['На 12 мес.', 'На 5 лет', 'До первой финансовой цели', 'Срок может меняться'],
        correctIndices: [3],
      ),
    ];
  }

  QuizResult evaluate(List<QuizQuestion> questions, Map<int, List<int>> answers) {
    int correct = 0;
    List<int> incorrect = [];
    List<String> recommendations = [];
    final Map<int, String> perFeedback = {};

    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      final user = answers[i] ?? [];
      final correctSet = q.correctIndices.toSet();
      final userSet = user.toSet();
      if (userSet.isNotEmpty && userSet.containsAll(correctSet) && correctSet.containsAll(userSet)) {
        correct++;
      } else {
        incorrect.add(i);
        final rec = _recommendationFor(q);
        recommendations.add(rec);
        // per-question feedback: if user selected some options, explain which were wrong
        String feedback;
        if (userSet.isEmpty) {
          feedback = q.explanation ?? 'Вы не выбрали ответ. ${rec}';
        } else {
          final wrong = user.where((idx) => !correctSet.contains(idx)).map((idx) => q.options[idx]).toList();
          final missed = correctSet.where((idx) => !userSet.contains(idx)).map((idx) => q.options[idx]).toList();
          final parts = <String>[];
          if (wrong.isNotEmpty) parts.add('Вы выбрали неверно: ${wrong.join(", ")}');
          if (missed.isNotEmpty) parts.add('Вы пропустили: ${missed.join(", ")}');
          feedback = '${parts.join('. ')}. ${q.explanation ?? rec}';
        }
        perFeedback[i] = feedback;
      }
    }
    // dedupe recommendations
    final deduped = recommendations.toSet().toList();

    return QuizResult(
      correctCount: correct,
      total: questions.length,
      incorrectQuestionIndexes: incorrect,
      recommendations: deduped,
      perQuestionFeedback: perFeedback,
      userAnswers: answers,
    );
  }

  // Public wrapper to get recommendation text for a question
  String recommendationFor(QuizQuestion q) => _recommendationFor(q);

  String _recommendationFor(QuizQuestion q) {
    final text = q.text.toLowerCase();
    if (text.contains('карточ') || text.contains('карта')) {
      return 'МТБанк: используйте виртуальные карты для онлайн-покупок, включайте push-уведомления и лимиты операций в мобильном приложении.';
    }
    if (text.contains('мошен') || text.contains('интернет')) {
      return 'Защитите себя: никогда не сообщайте одноразовые коды, используйте проверенные приложения МТБанк и активируйте подтверждение операций.';
    }
    if (text.contains('депозит')) {
      return 'Депозиты МТБанк — подберите срок и валюту под свою цель; для краткосрочных целей лучше выбирать гибкие продукты.';
    }
    if (text.contains('облигац') || text.contains('облигаций')) {
      return 'Облигации дают регулярный доход при меньшем риске чем акции; МТБанк публикует список доступных облигаций и рисков.';
    }
    if (text.contains('акций')) {
      return 'Акции могут приносить высокий доход, но и высокий риск. Диверсификация и долгосрочный горизонт — ключевые принципы.';
    }
    if (text.contains('кредит') || text.contains('кредитная')) {
      return 'Проверяйте условия кредита в МТБанк: меняйте срок или сумму чтобы корректировать ежемесячный платеж, используйте калькулятор в приложении.';
    }
    if (text.contains('план') || text.contains('финансов') || text.contains('цели')) {
      return 'Составляйте личный финансовый план: фиксируйте цели, сроки и инструменты. МТБанк предоставляет инструменты для накоплений и автоплатежей.';
    }

    return 'Рекомендуем ознакомиться с образовательными материалами и подсказками МТБанк в мобильном приложении для дальнейшего обучения.';
  }
}

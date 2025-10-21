import '../models/question.dart';
import '../models/test_result.dart';

class TestService {
  static final List<Question> questions = [
    Question(
      id: '1',
      text: '🎯 Какой тип задач приносит вам наибольшее удовлетворение?',
      options: [
        '🔧 Анализ данных, программирование, решение технических проблем',
        '💬 Общение с людьми, переговоры, помощь клиентам',
        '🎨 Создание дизайнов, визуальный контент, креативные проекты',
        '📊 Планирование, организация процессов, управление проектами'
      ],
      // Категории: [техника, социал, креатив, менеджмент]
      scores: [4, 1, 2, 3],
    ),
    Question(
      id: '2',
      text: '🏢 В какой рабочей среде вы наиболее продуктивны?',
      options: [
        '🤫 Тихий кабинет с возможностью глубокой концентрации',
        '🎉 Динамичный офис с постоянным общением и коллаборацией',
        '✨ Креативное пространство со свободой самовыражения',
        '📋 Структурированная среда с четкими процессами и дедлайнами'
      ],
      scores: [4, 2, 3, 3],
    ),
    Question(
      id: '3',
      text: '💡 Как вы предпочитаете решать сложные задачи?',
      options: [
        '📐 Методично анализировать данные и искать системное решение',
        '👥 Обсуждать с командой, собирать разные мнения и идеи',
        '🎭 Экспериментировать, пробовать нестандартные творческие подходы',
        '✅ Следовать проверенным методикам и пошаговым инструкциям'
      ],
      scores: [4, 2, 3, 2],
    ),
    Question(
      id: '4',
      text: '🚀 Что для вас важнее в профессиональном развитии?',
      options: [
        '⚡ Глубокие технические знания и экспертиза в узкой области',
        '🤝 Навыки коммуникации и построения долгосрочных отношений',
        '🌈 Творческая реализация и возможность самовыражения',
        '📈 Карьерный рост и развитие управленческих компетенций'
      ],
      scores: [4, 2, 3, 3],
    ),
    Question(
      id: '5',
      text: '🌟 Какой тип проектов вас больше привлекает?',
      options: [
        '💻 Сложные технические системы и алгоритмы',
        '❤️ Социальные проекты, работа с клиентами и сообществом',
        '🎬 Креативные кампании, брендинг, визуальные проекты',
        '📈 Бизнес-процессы, оптимизация, стратегическое планирование'
      ],
      scores: [4, 2, 4, 3],
    ),
    Question(
      id: '6',
      text: '🔄 Как вы относитесь к рутинным задачам?',
      options: [
        '👍 Могу работать с рутиной, если она технически интересна',
        '😴 Стараюсь избегать, предпочитаю живое общение и движение',
        '🎪 Выполняю, но быстро теряю интерес без творческой составляющей',
        '📝 Хорошо организован, умею эффективно планировать и выполнять рутину'
      ],
      scores: [3, 1, 2, 4],
    ),
    Question(
      id: '7',
      text: '🎭 Что лучше описывает ваш подход к работе?',
      options: [
        '🔬 Техническое совершенство и качество реализации',
        '💝 Построение отношений и эффективная коммуникация',
        '🎪 Инновации и творческий подход во всем',
        '⚖️ Организованность, надежность и системность'
      ],
      scores: [4, 2, 3, 3],
    ),
  ];

  static TestResult calculateResult(List<int> answers) {
    if (answers.length != questions.length) {
      throw ArgumentError('Количество ответов не совпадает с количеством вопросов');
    }

    // Упрощенная и исправленная система подсчета
    int techScore = 0;
    int creativeScore = 0;
    int socialScore = 0;
    int managementScore = 0;

    // Проходим по всем ответам и начисляем баллы в соответствующие категории
    for (int i = 0; i < answers.length; i++) {
      int selectedAnswer = answers[i];
      
      // Получаем баллы для выбранного ответа
      int score = questions[i].scores[selectedAnswer];
      
      // В зависимости от выбранного ответа, определяем, в какую категорию начислять баллы
      switch (selectedAnswer) {
        case 0: // Технический ответ
          techScore += score;
          break;
        case 1: // Социальный ответ
          socialScore += score;
          break;
        case 2: // Креативный ответ
          creativeScore += score;
          break;
        case 3: // Управленческий ответ
          managementScore += score;
          break;
      }
    }

    // Собираем все результаты для анализа
    Map<String, int> categoryScores = {
      'tech': techScore,
      'creative': creativeScore,
      'social': socialScore,
      'management': managementScore,
    };

    print('Final scores: $categoryScores'); // Для отладки

    // Находим доминирующую категорию
    var sortedCategories = categoryScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    String dominantCategory = sortedCategories.first.key;
    
    // Проверяем, нет ли близких вторых результатов (разница менее 15%)
    int maxScore = sortedCategories.first.value;
    bool hasCloseSecond = sortedCategories.length > 1 && 
        sortedCategories[1].value > 0 &&
        (maxScore - sortedCategories[1].value) <= (maxScore * 0.15);

    return _getDetailedResult(dominantCategory, categoryScores, hasCloseSecond);
  }

  // Остальной код _getDetailedResult остается без изменений...
  static TestResult _getDetailedResult(
    String category, 
    Map<String, int> scores, 
    bool hasCloseSecond
  ) {
    // [Ваш существующий код _getDetailedResult...]
    // Базовые описания для каждой категории
    final Map<String, Map<String, dynamic>> categoryData = {
      'tech': {
        'icon': '💻',
        'field': 'IT и Технические специальности',
        'description': 'Вы — технический гений! 🧠 Ваш аналитический склад ума и любовь к решению сложных задач делают вас идеальным кандидатом для IT-сферы. Вы наслаждаетесь погружением в код, алгоритмы и системные решения.',
        'primaryColor': '0xFF4CAF50',
        'secondaryColor': '0xFFE8F5E8',
      },
      'creative': {
        'icon': '🎨',
        'field': 'Творчество и Дизайн',
        'description': 'Вы — творческая душа! ✨ Ваше нестандартное мышление и чувство прекрасного позволяют создавать удивительные визуальные решения. Мир нуждается в вашей креативности и уникальном взгляде.',
        'primaryColor': '0xFF9C27B0',
        'secondaryColor': '0xFFF3E5F5',
      },
      'social': {
        'icon': '🤝',
        'field': 'Коммуникации и Работа с людьми',
        'description': 'Вы — мастер общения! 💫 Ваша эмпатия и умение находить подход к людям делают вас незаменимым в команде. Вы умеете слушать, понимать и вдохновлять окружающих.',
        'primaryColor': '0xFF2196F3',
        'secondaryColor': '0xFFE3F2FD',
      },
      'management': {
        'icon': '📊',
        'field': 'Управление и Бизнес',
        'description': 'Вы — прирожденный лидер! 🚀 Ваши организационные способности и стратегическое мышление помогают эффективно управлять проектами и командами. Вы видите картину в целом и умеете вести за собой.',
        'primaryColor': '0xFFFF9800',
        'secondaryColor': '0xFFFFF3E0',
      },
    };

    // Если есть близкий второй результат, добавляем гибридное описание
    String hybridNote = '';
    if (hasCloseSecond) {
      var sorted = scores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      String secondCategory = sorted[1].key;
      
      Map<String, String> hybridCombinations = {
        'tech_creative': '\n\n🎯 **Гибридный профиль**: Технический гений с творческим подходом! Вы можете создавать инновационные продукты на стыке технологий и дизайна.',
        'tech_management': '\n\n🎯 **Гибридный профиль**: Технический лидер! Вы сочетаете глубокие технические знания с управленческими навыками.',
        'creative_social': '\n\n🎯 **Гибридный профиль**: Творческий коммуникатор! Ваши идеи находят отклик благодаря умению общаться с аудиторией.',
        'social_management': '\n\n🎯 **Гибридный профиль**: Лидер-коммуникатор! Вы умеете и вдохновлять команду, и эффективно управлять процессами.',
      };
      
      String combo = '${sorted[0].key}_${sorted[1].key}';
      String reverseCombo = '${sorted[1].key}_${sorted[0].key}';
      hybridNote = hybridCombinations[combo] ?? hybridCombinations[reverseCombo] ?? '';
    }

    var data = categoryData[category] ?? categoryData['tech']!;

    // [Остальной код switch statement...]
    switch (category) {
      case 'tech':
        return TestResult(
          careerField: '${data['icon']} ${data['field']}',
          description: '${data['description']}$hybridNote',
          score: scores['tech']! / 28.0, // Максимально возможный балл = 7 вопросов * 4 балла = 28
          recommendedPositions: [
            '🚀 Backend-разработчик',
            '📊 Data Scientist', 
            '🔧 DevOps инженер',
            '🏗️ Системный архитектор',
            '🤖 Инженер машинного обучения',
            '🛡️ Специалист по кибербезопасности',
            '📱 Full-stack разработчик',
            '☁️ Cloud Engineer'
          ],
          strengths: [
            '🎯 Аналитическое мышление',
            '⚡ Техническая грамотность', 
            '🔍 Логическое мышление',
            '✨ Внимание к деталям',
            '💪 Решение сложных задач',
            '🚀 Быстрое обучение новым технологиям'
          ],
          improvements: [
            '📚 Изучите современные фреймворки и технологии',
            '🎯 Практикуйтесь в алгоритмах и структурах данных',
            '🔧 Освойте принципы DevOps и CI/CD',
            '📝 Развивайте навыки проектной документации',
            '👥 Изучите основы управления IT-проектами',
            '🌍 Участвуйте в open-source сообществе'
          ],
          nextSteps: [
            '💻 Пройти курсы по программированию (Python, Java, Go)',
            '🗄️ Изучить базы данных и SQL',
            '🔀 Освоить системы контроля версий (Git)',
            '⚡ Практиковаться на платформах типа LeetCode',
            '🌟 Участвовать в open-source проектах',
            '🎓 Посещать IT-конференции и митапы'
          ],
          primaryColor: data['primaryColor'],
          secondaryColor: data['secondaryColor'],
        );

      // [Остальные case-блоки...]
      case 'creative':
        return TestResult(
          careerField: '${data['icon']} ${data['field']}',
          description: '${data['description']}$hybridNote',
          score: scores['creative']! / 28.0,
          recommendedPositions: [
            '🎨 UX/UI дизайнер',
            '✏️ Графический дизайнер',
            '📱 Продуктовый дизайнер', 
            '👨‍🎨 Арт-директор',
            '🌐 Веб-дизайнер',
            '🎬 Моушн-дизайнер',
            '📸 Фотограф/Видеограф',
            '🖌️ Иллюстратор'
          ],
          strengths: [
            '✨ Креативное мышление',
            '🎯 Визуальное восприятие',
            '🌈 Чувство стиля и эстетики',
            '🚀 Нестандартный подход',
            '🔍 Внимание к визуальным деталям',
            '💡 Генерация идей'
          ],
          improvements: [
            '🛠️ Освойте Adobe Creative Suite (Photoshop, Illustrator)',
            '🎯 Изучите принципы UX/UI дизайна',
            '🔤 Развивайте навыки типографики и композиции',
            '📁 Создайте сильное портфолио',
            '💻 Изучите основы frontend-разработки',
            '📊 Освойте основы аналитики пользовательского поведения'
          ],
          nextSteps: [
            '📚 Собрать портфолио проектов',
            '🛠️ Изучить Figma и Sketch',
            '🎯 Практиковаться в создании дизайн-систем',
            '🧠 Изучить психологию восприятия',
            '🚀 Участвовать в дизайн-марафонах',
            '🌟 Следить за трендами в дизайне'
          ],
          primaryColor: data['primaryColor'],
          secondaryColor: data['secondaryColor'],
        );

      case 'social':
        return TestResult(
          careerField: '${data['icon']} ${data['field']}',
          description: '${data['description']}$hybridNote',
          score: scores['social']! / 28.0,
          recommendedPositions: [
            '📊 Менеджер по продукту',
            '👥 HR специалист',
            '🎯 Маркетолог',
            '📢 PR менеджер',
            '🎓 Коуч/Ментор',
            '🔍 Рекрутер',
            '💼 Менеджер по продажам',
            '🤝 Community Manager'
          ],
          strengths: [
            '💬 Коммуникативные навыки',
            '❤️ Эмпатия и понимание людей',
            '🤝 Умение убеждать и договариваться',
            '🔄 Адаптивность в общении',
            '🎤 Навыки публичных выступлений',
            '🌟 Построение отношений'
          ],
          improvements: [
            '💼 Развивайте навыки ведения переговоров',
            '🧠 Изучите основы психологии общения',
            '📊 Освойте инструменты аналитики',
            '🎤 Практикуйтесь в публичных выступлениях',
            '📋 Изучите методы управления проектами',
            '🌍 Развивайте межкультурную коммуникацию'
          ],
          nextSteps: [
            '🎓 Пройти курсы по коммуникациям',
            '📈 Изучить основы маркетинга и продаж',
            '🤝 Развивать нетворкинг',
            '📊 Освоить инструменты аналитики (Google Analytics)',
            '🎯 Практиковаться в проведении презентаций',
            '🌟 Участвовать в профессиональных сообществах'
          ],
          primaryColor: data['primaryColor'],
          secondaryColor: data['secondaryColor'],
        );

      case 'management':
        return TestResult(
          careerField: '${data['icon']} ${data['field']}',
          description: '${data['description']}$hybridNote',
          score: scores['management']! / 28.0,
          recommendedPositions: [
            '📋 Project Manager',
            '🚀 Product Manager',
            '📊 Бизнес-аналитик',
            '⚙️ Операционный менеджер',
            '🔄 Scrum Master',
            '🎯 Владелец продукта',
            '🏢 Руководитель отдела',
            '📈 Стратегический консультант'
          ],
          strengths: [
            '🗂️ Организационные навыки',
            '🎯 Стратегическое мышление',
            '👑 Лидерские качества',
            '📅 Планирование и прогнозирование',
            '💰 Управление ресурсами',
            '⚡ Принятие решений'
          ],
          improvements: [
            '🔄 Изучите Agile/Scrum методологии',
            '🛠️ Освойте инструменты управления проектами',
            '💳 Развивайте финансовую грамотность',
            '📈 Изучите основы бизнес-анализа',
            '🎯 Практикуйтесь в стратегическом планировании',
            '👥 Развивайте эмоциональный интеллект'
          ],
          nextSteps: [
            '🎓 Получить сертификацию PMP или Scrum Master',
            '🛠️ Освоить Jira, Trello, Asana',
            '💰 Изучить основы финансового учета',
            '👥 Развивать навыки проведения встреч',
            '🗺️ Практиковаться в создании дорожных карт',
            '🌟 Найти ментора в управлении'
          ],
          primaryColor: data['primaryColor'],
          secondaryColor: data['secondaryColor'],
        );

      default:
        return TestResult(
          careerField: '🎭 Универсальный специалист',
          description: 'Вы — многогранная личность! 🌟 Ваши разносторонние навыки позволяют успешно развиваться в разных направлениях. Вы быстро адаптируетесь и учитесь, что делает вас ценным сотрудником в современных динамичных компаниях.$hybridNote',
          score: 0.7,
          recommendedPositions: [
            '🚀 Product Manager',
            '👨‍💻 Tech Lead',
            '💼 Предприниматель',
            '📊 Консультант',
            '🔍 Аналитик',
            '🎯 Business Developer',
            '🔄 Project Coordinator'
          ],
          strengths: [
            '🔄 Гибкость и адаптивность',
            '🎯 Разносторонние интересы',
            '⚡ Быстрое обучение',
            '🌍 Широкий кругозор',
            '🤝 Умение работать в междисциплинарных командах',
            '💡 Системное мышление'
          ],
          improvements: [
            '🎯 Определить ключевые профессиональные интересы',
            '📚 Развивать специализацию в выбранном направлении',
            '🌟 Искать междисциплинарные проекты',
            '🤝 Строить профессиональную сеть контактов',
            '📊 Развивать экспертизу в смежных областях'
          ],
          nextSteps: [
            '🚀 Попробовать разные роли в стартапах',
            '🎓 Найти ментора в интересующей области',
            '💼 Участвовать в разнообразных проектах',
            '🌐 Посещать профессиональные конференции',
            '📚 Пройти курсы по смежным специальностям',
            '🤝 Развивать нетворкинг в разных индустриях'
          ],
          primaryColor: '0xFF607D8B',
          secondaryColor: '0xFFECEFF1',
        );
    }
  }

  // Дополнительный метод для получения детальной статистики
  static Map<String, double> getDetailedScores(List<int> answers) {
    // Пересчитываем баллы для детальной статистики
    int techScore = 0;
    int creativeScore = 0;
    int socialScore = 0;
    int managementScore = 0;

    for (int i = 0; i < answers.length; i++) {
      int selectedAnswer = answers[i];
      int score = questions[i].scores[selectedAnswer];
      
      switch (selectedAnswer) {
        case 0:
          techScore += score;
          break;
        case 1:
          socialScore += score;
          break;
        case 2:
          creativeScore += score;
          break;
        case 3:
          managementScore += score;
          break;
      }
    }

    return {
      'tech': techScore / 28.0,
      'creative': creativeScore / 28.0,
      'social': socialScore / 28.0,
      'management': managementScore / 28.0,
    };
  }
}
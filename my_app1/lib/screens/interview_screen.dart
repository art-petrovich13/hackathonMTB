import 'package:flutter/material.dart';

class InterviewQuestion {
  final String id;
  final String question;
  final String category;
  final List<String> tips;
  final String idealAnswer;
  final List<String> keywords;

  InterviewQuestion({
    required this.id,
    required this.question,
    required this.category,
    required this.tips,
    required this.idealAnswer,
    required this.keywords,
  });
}

class InterviewService {
  static Map<String, List<InterviewQuestion>> getInterviewQuestions() {
    return {
      'IT и Технологии': [
        InterviewQuestion(
          id: 'it1',
          question: 'Расскажите о своем опыте в программировании и какие технологии вы использовали?',
          category: 'Технические навыки',
          tips: [
            'Упомяните конкретные языки программирования',
            'Расскажите о реальных проектах',
            'Укажите уровень владения технологиями'
          ],
          idealAnswer: 'Я имею опыт работы с [технологии] в течение [время]. Разрабатывал(а) [проекты], где использовал(а) [конкретные навыки]. Особенно горжусь проектом [пример], где достиг(ла) [результат].',
          keywords: ['JavaScript', 'Python', 'React', 'базы данных', 'Git', 'API'],
        ),
        InterviewQuestion(
          id: 'it2',
          question: 'Как вы подходите к решению сложных технических проблем?',
          category: 'Решение проблем',
          tips: [
            'Опишите свой процесс анализа',
            'Упомяните отладку и тестирование',
            'Расскажите о работе с документацией'
          ],
          idealAnswer: 'Сначала анализирую проблему и воспроизвожу её. Использую логирование и отладку для идентификации корневой причины. Изучаю документацию и ищу похожие решения. Если нужно, консультируюсь с коллегами. После решения обязательно пишу тесты.',
          keywords: ['анализ', 'отладка', 'тестирование', 'документация', 'решение'],
        ),
        InterviewQuestion(
          id: 'it3',
          question: 'Как вы поддерживаете актуальность своих знаний в быстро меняющейся IT-сфере?',
          category: 'Саморазвитие',
          tips: [
            'Упомяните курсы и обучение',
            'Расскажите о профессиональных сообществах',
            'Укажите, как следите за трендами'
          ],
          idealAnswer: 'Регулярно читаю технические блоги и смотрю доклады с конференций. Прохожу онлайн-курсы на платформах типа Coursera. Участвую в open-source проектах. Посещаю местные митапы и практикуюсь в пет-проектах.',
          keywords: ['обучение', 'курсы', 'сообщество', 'тренды', 'практика'],
        ),
        InterviewQuestion(
          id: 'it4',
          question: 'Опишите ваш опыт работы в команде над IT-проектом',
          category: 'Командная работа',
          tips: [
            'Расскажите о методологиях',
            'Упомяните инструменты collaboration',
            'Опишите свою роль'
          ],
          idealAnswer: 'Работал(а) в команде по методологии Agile/Scrum. Использовали Jira для трекинга задач, Git для контроля версий и проводили код-ревью. Моя роль включала [конкретные обязанности], и мы успешно выпустили проект в срок.',
          keywords: ['Agile', 'Scrum', 'Git', 'команда', 'взаимодействие'],
        ),
      ],
      'Маркетинг и Продажи': [
        InterviewQuestion(
          id: 'm1',
          question: 'Как вы оцениваете эффективность маркетинговой кампании?',
          category: 'Аналитика',
          tips: [
            'Упомяните ключевые метрики',
            'Расскажите об инструментах аналитики',
            'Опишите процесс оптимизации'
          ],
          idealAnswer: 'Оцениваю по ключевым метрикам: ROI, CTR, конверсия, стоимость привлечения клиента. Использую Google Analytics, CRM системы. Анализирую данные и корректирую стратегию для улучшения показателей.',
          keywords: ['ROI', 'CTR', 'конверсия', 'аналитика', 'метрики'],
        ),
        InterviewQuestion(
          id: 'm2',
          question: 'Расскажите о самом успешном маркетинговом проекте в вашей карьере',
          category: 'Опыт',
          tips: [
            'Используйте цифры и факты',
            'Опишите свою роль',
            'Упомяните достигнутые результаты'
          ],
          idealAnswer: 'В проекте [название] моя стратегия привела к увеличению трафика на X% и росту конверсии на Y%. Я отвечал(а) за [обязанности], и мы достигли [конкретные измеримые результаты].',
          keywords: ['результаты', 'стратегия', 'рост', 'успех', 'показатели'],
        ),
        InterviewQuestion(
          id: 'm3',
          question: 'Как вы работаете с возражениями клиентов?',
          category: 'Продажи',
          tips: [
            'Опишите технику работы',
            'Приведите пример',
            'Упомяните эмпатию'
          ],
          idealAnswer: 'Сначала внимательно выслушиваю возражение, затем задаю уточняющие вопросы. Использую технику "согласие-противопоставление". Привожу конкретные примеры и данные. Всегда сохраняю профессиональное и уважительное отношение.',
          keywords: ['возражения', 'эмпатия', 'решение', 'клиент', 'общение'],
        ),
        InterviewQuestion(
          id: 'm4',
          question: 'Какие digital-маркетинг инструменты вы используете и почему?',
          category: 'Инструменты',
          tips: [
            'Объясните выбор инструментов',
            'Упомяните эффективность',
            'Расскажите об интеграциях'
          ],
          idealAnswer: 'Использую Google Ads для поискового трафика, Meta Ads для таргетинга, Ahrefs для SEO-анализа. Эти инструменты доказали свою эффективность в моих предыдущих проектах и хорошо интегрируются между собой.',
          keywords: ['инструменты', 'digital', 'эффективность', 'анализ', 'интеграция'],
        ),
      ],
      'Творчество и Дизайн': [
        InterviewQuestion(
          id: 'd1',
          question: 'Опишите ваш творческий процесс от идеи до реализации',
          category: 'Процесс',
          tips: [
            'Расскажите о этапах',
            'Упомяните источники вдохновения',
            'Опишите инструменты'
          ],
          idealAnswer: 'Начинаю с исследования и сбора референсов. Затем создаю мудборд и скетчи. После утверждения концепции перехожу к детальной проработке в Figma/Adobe. На каждом этапе согласовываю с клиентом и вношу правки.',
          keywords: ['процесс', 'исследование', 'скетчи', 'итерации', 'фидбек'],
        ),
        InterviewQuestion(
          id: 'd2',
          question: 'Как вы обрабатываете критику и правки от клиентов?',
          category: 'Коммуникация',
          tips: [
            'Покажите профессиональный подход',
            'Упомяните важность фидбека',
            'Расскажите о балансе'
          ],
          idealAnswer: 'Воспринимаю критику как возможность улучшить работу. Задаю уточняющие вопросы чтобы понять потребности клиента. Объясняю профессиональную точку зрения, но всегда приоритетом считаю цели бизнеса клиента.',
          keywords: ['критика', 'фидбек', 'коммуникация', 'профессионализм', 'адаптация'],
        ),
        InterviewQuestion(
          id: 'd3',
          question: 'Какие тренды в дизайне вы считаете наиболее перспективными?',
          category: 'Тренды',
          tips: [
            'Продемонстрируйте осведомленность',
            'Объясните почему',
            'Упомяните практическое применение'
          ],
          idealAnswer: 'Сейчас важны accessibility, темные темы, неоморфизм и 3D элементы. Эти тренды улучшают пользовательский опыт и соответствуют современным стандартам. В своих проектах я применяю [конкретные примеры].',
          keywords: ['тренды', 'UX', 'доступность', 'инновации', 'применение'],
        ),
        InterviewQuestion(
          id: 'd4',
          question: 'Как вы измеряете успешность дизайна?',
          category: 'Результаты',
          tips: [
            'Упомяните метрики',
            'Расскажите о тестировании',
            'Опишите feedback loops'
          ],
          idealAnswer: 'Успешность измеряю через пользовательские метрики: вовлеченность, конверсия, отзывы. Провожу A/B тестирование, анализирую тепловые карты. Важно сочетать количественные данные с качественными отзывами пользователей.',
          keywords: ['метрики', 'тестирование', 'отзывы', 'конверсия', 'анализ'],
        ),
      ],
    };
  }

  static Map<String, Map<String, List<String>>> getCareerImprovements() {
    return {
      'IT и Технологии': {
        'Технические навыки': [
          'Изучите современные фреймворки (React, Vue, Angular)',
          'Освойте облачные технологии (AWS, Azure, GCP)',
          'Практикуйтесь в алгоритмах и структурах данных',
          'Изучите принципы DevOps и CI/CD'
        ],
        'Soft Skills': [
          'Развивайте навыки презентации технических решений',
          'Практикуйтесь в написании технической документации',
          'Улучшайте навыки менторства и код-ревью',
          'Развивайте умение объяснять сложные концепции простыми словами'
        ],
        'Практика': [
          'Участвуйте в open-source проектах',
          'Создайте пет-проект с использованием новых технологий',
          'Решайте задачи на LeetCode или HackerRank',
          'Посещайте технические митапы и конференции'
        ]
      },
      'Маркетинг и Продажи': {
        'Аналитика': [
          'Освойте Google Analytics 4 и Яндекс.Метрику',
          'Изучите основы SQL для работы с данными',
          'Научитесь строить дашборды в Data Studio',
          'Освойте A/B тестирование и статистический анализ'
        ],
        'Инструменты': [
          'Изучите автоматизацию маркетинга (HubSpot, Marketo)',
          'Освойте работу с CRM системами',
          'Научитесь использовать инструменты для email-маркетинга',
          'Изучите платформы для SMM-аналитики'
        ],
        'Стратегия': [
          'Практикуйтесь в создании маркетинговых воронок',
          'Изучите методы ценообразования',
          'Освойте техники копирайтинга',
          'Развивайте навыки нейромаркетинга'
        ]
      },
      'Творчество и Дизайн': {
        'Технические навыки': [
          'Освойте Adobe Creative Suite на продвинутом уровне',
          'Изучите принципы анимации в After Effects',
          'Практикуйтесь в 3D моделировании',
          'Освойте проектирование UX research'
        ],
        'Теория': [
          'Изучите психологию восприятия цвета',
          'Освойте принципы типографики и верстки',
          'Изучите accessibility guidelines (WCAG)',
          'Углубите знания по композиции и визуальной иерархии'
        ],
        'Портфолио': [
          'Создайте case studies с метриками успеха',
          'Разработайте персональный бренд',
          'Участвуйте в design challenges',
          'Собирайте и анализируйте feedback на свои работы'
        ]
      }
    };
  }
}

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
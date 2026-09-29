import 'package:flutter/material.dart';
import '../../models/interview_question.dart';
import '../../models/test_result.dart';
import 'package:my_app1/screens/interview/interview_builder.dart';
import 'package:my_app1/screens/interview/interview_service.dart';
import '../../models/interview_service.dart' as model_service;

class ChatMessage {
  final String text;
  final bool isInterviewer;
  final DateTime time;
  ChatMessage(this.text, {this.isInterviewer = true}) : time = DateTime.now();
}

class InterviewController extends ChangeNotifier {
  final String careerField;
  final TestResult? testResult;

  int currentQuestionIndex = 0;
  List<InterviewQuestion> questions = [];
  List<String> userAnswers = [];
  List<Map<String, dynamic>?> evaluations = [];
  bool showTips = false;
  bool interviewCompleted = false;
  Map<String, List<String>> improvements = {};
  final List<ChatMessage> messages = [];
  final TextEditingController textController = TextEditingController();
  bool interviewerTyping = false;

  InterviewController({required this.careerField, this.testResult}) {
    _initData();
  }

  void _initData() {
    if (testResult != null) {
      questions = InterviewBuilder.buildFromTestResult(testResult!);
      improvements = InterviewService.getCareerImprovements()[careerField] ?? {};
    } else {
      questions = InterviewService.getInterviewQuestions()[careerField] ?? [];
      improvements = InterviewService.getCareerImprovements()[careerField] ?? {};
    }
    userAnswers = List.filled(questions.length, '');
    evaluations = List.filled(questions.length, null);
    // show first question as message (UI will request this after build)
  }

  Future<void> showInterviewerQuestion() async {
    if (questions.isEmpty) return;
    final q = questions[currentQuestionIndex];
    interviewerTyping = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 800 + q.question.length * 8));
    interviewerTyping = false;
    messages.add(ChatMessage(q.question, isInterviewer: true));
    notifyListeners();
  }

  void toggleTips() {
    showTips = !showTips;
    notifyListeners();
  }

  void restartInterview() {
    currentQuestionIndex = 0;
    userAnswers = List.filled(questions.length, '');
    showTips = false;
    interviewCompleted = false;
    messages.clear();
    evaluations = List.filled(questions.length, null);
    notifyListeners();
  }

  void completeInterview() {
    interviewCompleted = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      showTips = false;
      notifyListeners();
      showInterviewerQuestion();
    } else {
      completeInterview();
    }
  }

  void sendAnswer() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    messages.add(ChatMessage(text, isInterviewer: false));
    userAnswers[currentQuestionIndex] = text;
    textController.clear();
    interviewerTyping = true;
    notifyListeners();

    final answeredQuestion = questions[currentQuestionIndex];
    Future.delayed(const Duration(milliseconds: 600), () {
      Map<String, dynamic>? eval;
      final matches = model_service.InterviewService.allQuestions.where((cq) => cq.id == answeredQuestion.id).toList();
      if (matches.isNotEmpty) {
        eval = model_service.InterviewService.evaluateAnswer(text, matches.first);
      }
      evaluations[currentQuestionIndex] = eval;
      messages.add(ChatMessage("Спасибо за ваш ответ!", isInterviewer: true));
      interviewerTyping = false;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 800), () {
        nextQuestion();
      });
    });
  }

  Map<String, dynamic> calculateScores() {
    final per = <double>[];
    double sum = 0.0;
    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      final ans = userAnswers[i].toLowerCase();
      double score = 0.0;
      if (ans.isEmpty) {
        score = 0.0;
      } else if (q.keywords.isNotEmpty) {
        int matched = 0;
        for (var kw in q.keywords) {
          if (ans.contains(kw.toLowerCase())) matched++;
        }
        final kwFrac = matched / q.keywords.length;
        final lengthScore = (ans.split(RegExp(r'\s+')).length / 30).clamp(0.0, 1.0);
        score = (kwFrac * 0.75 + lengthScore * 0.25).clamp(0.0, 1.0);
      } else {
        score = (ans.split(RegExp(r'\s+')).length / 30).clamp(0.0, 1.0);
      }
      per.add(score);
      sum += score;
    }
    final avg = questions.isEmpty ? 0.0 : (sum / questions.length) * 100.0;
    return {'total': avg, 'perQuestion': per};
  }

  /// Get recommended resources for this career field (from InterviewService)
  List<Map<String, dynamic>> getRecommendedResources() {
    return model_service.InterviewService.getRecommendedResources()[careerField] ?? [];
  }

  /// Estimate probability of passing based on scores and optionally user improvements.
  /// We use average score (0..100) and scale it to a pass probability, then
  /// increase probability slightly if recommended resources are likely completed (not tracked here).
  double estimatePassProbability() {
    final scores = calculateScores();
    double avg = (scores['total'] as double) / 100.0; // 0..1
    // Make formula stricter: scale down slightly and keep modest baseline
    // This makes it harder to reach very high probabilities.
    double prob = (avg * 0.7) + 0.05;
    // Penalize empty answers: if many answers are empty, reduce probability
    final emptyCount = userAnswers.where((a) => a.trim().isEmpty).length;
    if (questions.isNotEmpty) {
      final emptyFrac = emptyCount / questions.length;
      prob = prob * (1.0 - (emptyFrac * 0.5)); // up to 50% penalty
    }
    // clamp
    if (prob < 0.01) prob = 0.01;
    if (prob > 0.99) prob = 0.99;
    return prob;
  }

  /// Returns a human-friendly category based on estimated probability.
  /// <50% — мало шансов, 50-70% — возможно, 70%+ — хорошая кандидатура
  String passCategoryLabel() {
    final p = (estimatePassProbability() * 100).round();
    if (p < 50) return 'Мало шансов (<50%)';
    if (p < 70) return 'Возможно (50–70%)';
    return 'Хорошая кандидатура (>=70%)';
  }

  /// Color for the pass category badge
  Color passCategoryColor() {
    final p = (estimatePassProbability() * 100).round();
    if (p < 50) return Colors.red.shade600;
    if (p < 70) return Colors.orange.shade700;
    return Colors.green.shade700;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}


class QuizResult {
  final int correctCount;
  final int total;
  final List<int> incorrectQuestionIndexes;
  final List<String> recommendations;
  final Map<int, String> perQuestionFeedback; // index -> feedback
  final Map<int, List<int>> userAnswers;

  QuizResult({
    required this.correctCount,
    required this.total,
    required this.incorrectQuestionIndexes,
    required this.recommendations,
    required this.perQuestionFeedback,
    required this.userAnswers,
  });
}

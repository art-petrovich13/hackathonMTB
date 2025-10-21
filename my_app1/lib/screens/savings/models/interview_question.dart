// lib/models/interview_question.dart
class InterviewQuestion {
  final String id;
  final String question;
  final String category;
  final String difficulty;
  final List<String> tips;
  final String idealAnswer;
  final List<String> keywords;
  final int timeLimit;

  const InterviewQuestion({
    required this.id,
    required this.question,
    required this.category,
    required this.difficulty,
    required this.tips,
    required this.idealAnswer,
    required this.keywords,
    required this.timeLimit,
  });
}
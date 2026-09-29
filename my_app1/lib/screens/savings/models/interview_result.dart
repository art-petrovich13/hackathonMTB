// lib/models/interview_result.dart
class InterviewResult {
  final String id;
  final DateTime completedAt;
  final int totalScore;
  final int totalQuestions;
  final Map<String, int> categoryScores;
  final int totalTime;
  final List<String> strengths;
  final List<String> improvements;

  const InterviewResult({
    required this.id,
    required this.completedAt,
    required this.totalScore,
    required this.totalQuestions,
    required this.categoryScores,
    required this.totalTime,
    required this.strengths,
    required this.improvements,
  });

  double get averageScore => totalQuestions > 0 ? totalScore / totalQuestions : 0;
  
  String get formattedTime {
    final minutes = totalTime ~/ 60;
    final seconds = totalTime % 60;
    return '${minutes}м ${seconds}с';
  }
}
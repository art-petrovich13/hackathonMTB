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
    this.keywords = const [],
  });
}
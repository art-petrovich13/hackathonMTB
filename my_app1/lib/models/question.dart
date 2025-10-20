class Question {
  final String id;
  final String text;
  final List<String> options;
  final List<int> scores;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.scores,
  });
}
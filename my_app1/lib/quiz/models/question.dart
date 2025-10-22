class QuizQuestion {
  final String id;
  final String text;
  final List<String> options;
  final List<int> correctIndices; // allow multiple correct answers
  final bool multiple;
  final String? explanation; // short explanation shown when user misses

  QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndices,
    this.multiple = false,
    this.explanation,
  });
}

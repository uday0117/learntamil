class QuizQuestion {
  final String id;
  final String tamil;
  final String transliteration;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  /// Backward-compatible alias
  String get kannada => tamil;

  const QuizQuestion({
    required this.id,
    required this.tamil,
    required this.transliteration,
    required this.options,
    required this.correctIndex,
    this.explanation = '',
  });

  String get correctAnswer => options[correctIndex];
}

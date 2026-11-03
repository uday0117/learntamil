import 'learning_item.dart';

class QuizQuestion {
  final String id;
  final String tamil;
  final String transliteration;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final ItemType type;

  const QuizQuestion({
    required this.id,
    required this.tamil,
    required this.transliteration,
    required this.options,
    required this.correctIndex,
    this.explanation = '',
    this.type = ItemType.word,
  });

  String get correctAnswer => options[correctIndex];
  bool get isSentence => type == ItemType.sentence;
  bool get isWord => type == ItemType.word;
}

import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import '../models/learning_item.dart';
import '../models/quiz_question.dart';
import 'tamil_data.dart';

abstract class IContentRepository {
  List<LearningItem> getWords();
  List<String> getWordCategories();
  List<LearningItem> getSentences();
  List<String> getSentenceCategories();
  List<LearningItem> getAllItems();
  LearningItem? getItemById(String id);
  List<LearningItem> search(String query, {ItemType? filterType});
  List<QuizQuestion> generateQuiz({int questionCount = 10, ItemType? itemType});
}

class ContentRepository implements IContentRepository {
  static final ContentRepository _instance = ContentRepository._internal();
  factory ContentRepository() => _instance;
  ContentRepository._internal();

  List<LearningItem> _words = bundledWords;
  List<LearningItem> _sentences = bundledSentences;

  /// Loads words and sentences from bundled JSON assets with instant fallback
  Future<void> init() async {
    try {
      final wordsString = await rootBundle.loadString('assets/data/words.json');
      final List<dynamic> jsonList = jsonDecode(wordsString) as List<dynamic>;
      final parsed = jsonList
          .map((item) => LearningItem.fromJson(item as Map<String, dynamic>))
          .toList();
      if (parsed.isNotEmpty) {
        _words = parsed;
      }
    } catch (_) {
      // Keep bundledWords fallback
    }

    try {
      final sentencesString =
          await rootBundle.loadString('assets/data/sentences.json');
      final List<dynamic> jsonList =
          jsonDecode(sentencesString) as List<dynamic>;
      final parsed = jsonList
          .map((item) => LearningItem.fromJson(item as Map<String, dynamic>))
          .toList();
      if (parsed.isNotEmpty) {
        _sentences = parsed;
      }
    } catch (_) {
      // Keep bundledSentences fallback
    }
  }

  @override
  List<LearningItem> getWords() => List.unmodifiable(_words);

  @override
  List<String> getWordCategories() {
    final categories = _words.map((w) => w.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  @override
  List<LearningItem> getSentences() => List.unmodifiable(_sentences);

  @override
  List<String> getSentenceCategories() {
    final categories = _sentences.map((s) => s.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  @override
  List<LearningItem> getAllItems() =>
      List.unmodifiable([..._words, ..._sentences]);

  @override
  LearningItem? getItemById(String id) {
    try {
      return [..._words, ..._sentences].firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  static String _stripDiacritics(String text) {
    return text
        .toLowerCase()
        .replaceAll('ā', 'a')
        .replaceAll('ē', 'e')
        .replaceAll('ī', 'i')
        .replaceAll('ō', 'o')
        .replaceAll('ū', 'u')
        .replaceAll('ḍ', 'd')
        .replaceAll('ṭ', 't')
        .replaceAll('ḷ', 'l')
        .replaceAll('ṇ', 'n')
        .replaceAll('ṣ', 's')
        .replaceAll('ṅ', 'n')
        .replaceAll('ṟ', 'r')
        .replaceAll('ḻ', 'zh');
  }

  @override
  List<LearningItem> search(String query, {ItemType? filterType}) {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return const [];
    final normalizedQuery = _stripDiacritics(trimmed);

    List<LearningItem> source;
    if (filterType == ItemType.word) {
      source = _words;
    } else if (filterType == ItemType.sentence) {
      source = _sentences;
    } else {
      source = [..._words, ..._sentences];
    }

    return source.where((item) {
      final matchTamil = item.tamil.toLowerCase().contains(trimmed);
      final matchTrans = _stripDiacritics(item.transliteration).contains(normalizedQuery) ||
          item.transliteration.toLowerCase().contains(trimmed);
      final matchEnglish = item.english.toLowerCase().contains(trimmed);
      return matchTamil || matchTrans || matchEnglish;
    }).toList();
  }

  @override
  List<QuizQuestion> generateQuiz({
    int questionCount = 10,
    ItemType? itemType,
  }) {
    final random = Random();

    List<LearningItem> pool;
    if (itemType == ItemType.word) {
      pool = List<LearningItem>.from(_words)..shuffle(random);
    } else if (itemType == ItemType.sentence) {
      pool = List<LearningItem>.from(_sentences)..shuffle(random);
    } else {
      // Mixed mode: randomly mix both words and sentences
      // To ensure a rich, well-distributed experience, randomly sample from both
      final targetWords = (questionCount / 2).round();
      final targetSentences = questionCount - targetWords;

      final shuffledWords = List<LearningItem>.from(_words)..shuffle(random);
      final shuffledSentences = List<LearningItem>.from(_sentences)..shuffle(random);

      final selectedWords = shuffledWords.take(targetWords).toList();
      final selectedSentences = shuffledSentences.take(targetSentences).toList();

      pool = [...selectedWords, ...selectedSentences]..shuffle(random);
    }

    final count = min(questionCount, pool.length);
    final selectedItems = pool.take(count).toList();

    final List<QuizQuestion> questions = [];

    for (int i = 0; i < selectedItems.length; i++) {
      final current = selectedItems[i];
      final correctAnswer = current.english;

      // Pick 3 random distractor answers matching the item's type (word or sentence)
      // so distractors are natural, plausible, and grammatically comparable
      final candidateSource = current.isSentence ? _sentences : _words;
      final otherAnswers = candidateSource
          .where((item) => item.id != current.id && item.english != correctAnswer)
          .map((item) => item.english)
          .toSet()
          .toList()
        ..shuffle(random);

      final distractorOptions = otherAnswers.take(3).toList();
      final allOptions = [...distractorOptions, correctAnswer]..shuffle(random);

      final correctIndex = allOptions.indexOf(correctAnswer);

      questions.add(
        QuizQuestion(
          id: 'q_${i + 1}',
          tamil: current.tamil,
          transliteration: current.transliteration,
          options: allOptions,
          correctIndex: correctIndex,
          type: current.type,
        ),
      );
    }

    return questions;
  }
}

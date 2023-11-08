part of '../korean_learners_dictionary.dart';

/// XML element called "item".
abstract class Item {
  const Item({
    required this.word,
    required this.pos,
    required this.targetCode,
    required this.supNo,
    required this.link,
    this.wordGrade,
  });

  /// Word text.
  final String word;

  final PartOfSpeech pos;

  /// ID on krdict.korean.go.kr's database.
  final int targetCode;

  /// Number of homonym.
  ///
  /// This is to differentiate from different meanings.
  final int supNo;

  /// Word level.
  ///
  /// Response: 초급, 중급, 고급
  ///
  /// Request: level=[all/level1/level2/level3]
  ///
  /// It is a required item in the response coming from api/view. Instead of
  /// null (not coming) it comes as "없음".
  final WordGrade? wordGrade;

  /// URL to see the word.
  final String link;
}

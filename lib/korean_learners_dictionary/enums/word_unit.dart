part of '../korean_learners_dictionary.dart';

/// 구성 단위
///
/// (word_unit)
enum WordUnit {
  word("단어"),
  phrase("구"),
  expression("문법 표현");

  const WordUnit(this.hangul);

  final String hangul;

  static WordUnit? fromHangul(String hangul) =>
      values.firstWhereOrNull((e) => e.hangul == hangul);
}

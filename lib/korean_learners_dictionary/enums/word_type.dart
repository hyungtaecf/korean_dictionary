part of '../korean_learners_dictionary.dart';

/// 고유어 여부
///
/// (word_type)
enum WordType {
  native("고유어"),
  chinese("한자어"),
  loanword("외래어"),
  hybrid("혼종어"),
  ;

  const WordType(this.hangul);

  final String hangul;

  static WordType? fromHangul(String hangul) {
    // It might come as "한자" instead of "한자어"
    if (hangul == "한자") return chinese;
    return values.firstWhereOrNull((e) => e.hangul == hangul);
  }
}

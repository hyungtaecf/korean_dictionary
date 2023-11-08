part of '../korean_learners_dictionary.dart';

/// Part-of-speech (Word class)
///
/// - 명사
/// - 대명사
/// - 수사
/// - 조사
/// - 동사
/// - 형용사
/// - 관형사
/// - 부사
/// - 감탄사
/// - 접사
/// - 의존 명사
/// - 보조 동사
/// - 보조 형용사
/// - 어미
/// - 품사 없음
enum PartOfSpeech {
  noun('명사'),
  pronoun('대명사'),
  numeral('수사'),
  postpositionalParticle('조사'),
  verb('동사'),
  adjective('형용사'),
  determiner('determiner'),
  adverb('부사'),
  interjection('감탄사'),
  affix('접사'),
  boundNoun('의존 명사'),
  auxiliaryVerb('보조 동사'),
  auxiliaryAdjective('보조 형용사'),
  ending('어미'),
  none('품사 없음');

  const PartOfSpeech(this.hangul);

  final String hangul;

  int get code => index + 1;

  static PartOfSpeech fromHangul(String hangul) =>
      values.firstWhereOrNull((pos) => pos.hangul == hangul) ?? none;
}

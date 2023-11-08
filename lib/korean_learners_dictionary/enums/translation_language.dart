part of '../korean_learners_dictionary.dart';

/// (trans_lang)
/// 전체(0), 영어(1), 일본어(2), 프랑스어(3), 스페인어(4), 아랍어(5), 몽골어(6), 베트남어(7),
/// 타이어(8), 인도네시아어(9), 러시아어(10), 중국어(11)
enum TranslationLanguage {
  english('영어'),
  japanese('일본어', '。'),
  french('프랑스어'),
  spanish('스페인어'),
  arabic('아랍어', '،'),
  mongolian('몽골어'),
  vietnamese('베트남어'),
  thai('타이어'),
  indonesian('인도네시아어'),
  russian('러시아어'),
  chinese('중국어'),
  ;

  const TranslationLanguage(this.hangul, [this.wordSeparator]);

  int get code => index + 1;
  final String hangul;
  final String? wordSeparator;

  static TranslationLanguage? fromHangul(String hangul) =>
      values.firstWhereOrNull((lang) => lang.hangul == hangul);
}

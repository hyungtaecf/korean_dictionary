part of '../korean_learners_dictionary.dart';

/// Word level.
///
/// Response: 초급, 중급, 고급
///
/// Request: level=[all/level1/level2/level3]
///
/// It is a required item in the response coming from api/view. Instead of
/// null (not coming) it comes as "없음".
enum WordGrade {
  level1('초급'),
  level2('중급'),
  level3('고급'),
  ;

  const WordGrade(this.res);

  /// Name in requests.
  final String res;

  /// Name in responses.
  String get req => name;

  static WordGrade? fromHangul(String hangul) =>
      values.firstWhereOrNull((level) => level.res == hangul);
}

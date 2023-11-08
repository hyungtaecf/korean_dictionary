part of '../korean_learners_dictionary.dart';

/// 검색 방식(기본값 exact)
enum SearchMethod {
  /// exact: 일치 검색
  exact,

  /// 대상 코드(target_code)
  include,

  /// start: 시작
  start,

  /// end: 끝
  end
}

/// 검색 방식(기본값 word_info)
enum ViewMethod {
  /// 표제어 정보(표제어 + 어깨 번호)
  wordInfo('word_info'),

  /// 대상 코드(target_code)
  targetCode('target_code'),
  ;

  const ViewMethod(this.name);
  final String name;
}

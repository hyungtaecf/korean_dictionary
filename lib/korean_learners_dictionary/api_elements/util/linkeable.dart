part of '../../korean_learners_dictionary.dart';

/// Utility class with link fields to be inherited from.
abstract class Linkeable {
  const Linkeable({
    required this.word,
    required this.linkType,
    this.link,
    this.linkTargetCode,
  });

  /// 표제어
  final String word;

  /// 연결 유형(C : 링크 대상 코드 있음, T : 링크 대상 코드 없음)
  ///
  /// (link_type)
  final String linkType;

  /// 링크 대상 코드
  ///
  /// (link_target_code)
  final String? linkTargetCode;

  final String? link;

  Map<String, dynamic> toMap() => {
        ApiXmlElement.word.name: word,
        ApiXmlElement.linkType.name: linkType,
        if (linkTargetCode != null)
          ApiXmlElement.linkTargetCode.name: linkTargetCode,
        if (link != null) ApiXmlElement.link.name: link,
      };
}

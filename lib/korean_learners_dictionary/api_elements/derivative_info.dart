part of '../korean_learners_dictionary.dart';

/// Derivative
///
/// 파생어 항목
///
/// (der_info)
class DerivativeInfo extends Linkeable {
  const DerivativeInfo({
    required super.word,
    required super.linkType,
    super.link,
    super.linkTargetCode,
  });
  factory DerivativeInfo.fromXmlElement(XmlElement data) {
    final word = data.getElement(ApiXmlElement.word.name)!.innerText.trim();
    final linkType =
        data.getElement(ApiXmlElement.linkType.name)!.innerText.trim();
    final link = data.getElement(ApiXmlElement.link.name)?.innerText.trim();
    final linkTargetCode =
        data.getElement(ApiXmlElement.linkTargetCode.name)?.innerText.trim();
    return DerivativeInfo(
      word: word,
      linkType: linkType,
      link: link,
      linkTargetCode: linkTargetCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DerivativeInfo &&
        word == other.word &&
        linkType == other.linkType &&
        link == other.link &&
        linkTargetCode == other.linkTargetCode;
  }

  @override
  int get hashCode =>
      word.hashCode ^
      linkType.hashCode ^
      link.hashCode ^
      linkTargetCode.hashCode;
}

part of '../korean_learners_dictionary.dart';

/// Reference Information
///
/// 가봐라
///
/// (ref_info)
class ReferenceInfo extends Linkeable {
  const ReferenceInfo({
    required super.word,
    required super.linkType,
    super.link,
    super.linkTargetCode,
  });

  factory ReferenceInfo.fromXmlElement(XmlElement data) {
    final word = data.getElement(ApiXmlElement.word.name)!.innerText.trim();
    final linkType =
        data.getElement(ApiXmlElement.linkType.name)!.innerText.trim();
    final link = data.getElement(ApiXmlElement.link.name)?.innerText.trim();
    final linkTargetCode =
        data.getElement(ApiXmlElement.linkTargetCode.name)?.innerText.trim();
    return ReferenceInfo(
      word: word,
      linkType: linkType,
      link: link,
      linkTargetCode: linkTargetCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReferenceInfo &&
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

part of '../korean_learners_dictionary.dart';

/// 관련어
///
/// (rel_info)
class RelatedInfo extends Linkeable {
  const RelatedInfo({
    required this.type,
    required super.word,
    required super.linkType,
    super.link,
    super.linkTargetCode,
  });

  factory RelatedInfo.fromXmlElement(XmlElement data) {
    final type = data.getElement(ApiXmlElement.type.name)!.innerText.trim();
    final word = data.getElement(ApiXmlElement.word.name)!.innerText.trim();
    final linkType =
        data.getElement(ApiXmlElement.linkType.name)!.innerText.trim();
    final link = data.getElement(ApiXmlElement.link.name)?.innerText.trim();
    final linkTargetCode =
        data.getElement(ApiXmlElement.linkTargetCode.name)?.innerText.trim();
    return RelatedInfo(
      type: type,
      word: word,
      linkType: linkType,
      link: link,
      linkTargetCode: linkTargetCode,
    );
  }

  final String type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RelatedInfo &&
        type == other.type &&
        word == other.word &&
        linkType == other.linkType &&
        link == other.link &&
        linkTargetCode == other.linkTargetCode;
  }

  @override
  int get hashCode =>
      type.hashCode ^
      word.hashCode ^
      linkType.hashCode ^
      link.hashCode ^
      linkTargetCode.hashCode;
}

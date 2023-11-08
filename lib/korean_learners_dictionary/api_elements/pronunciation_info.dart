part of '../korean_learners_dictionary.dart';

/// (pronunciation_info)
class PronunciationInfo {
  const PronunciationInfo({
    required this.pronunciation,
    this.link,
  });

  factory PronunciationInfo.fromXmlElement(XmlElement data) {
    final pronunciation =
        data.getElement(ApiXmlElement.pronunciation.name)!.innerText.trim();
    final link = data.getElement(ApiXmlElement.link.name)?.innerText.trim();
    return PronunciationInfo(
      pronunciation: pronunciation,
      link: link,
    );
  }

  final String pronunciation;
  final String? link;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PronunciationInfo &&
        pronunciation == other.pronunciation &&
        link == other.link;
  }

  @override
  int get hashCode => pronunciation.hashCode ^ link.hashCode;
}

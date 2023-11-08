part of '../korean_learners_dictionary.dart';

/// (abbreviation_info)
class AbbreviationInfo {
  AbbreviationInfo({
    required this.abbreviation,
    this.pronunciationInfo,
  });

  factory AbbreviationInfo.fromXmlElement(XmlElement data) {
    final abbreviation =
        data.getElement(ApiXmlElement.abbreviation.name)!.innerText.trim();
    final aux = data.getElement(ApiXmlElement.pronunciationInfo.name);
    final pronunciationInfo =
        aux == null ? null : PronunciationInfo.fromXmlElement(aux);
    return AbbreviationInfo(
      abbreviation: abbreviation,
      pronunciationInfo: pronunciationInfo,
    );
  }

  final String abbreviation;
  final PronunciationInfo? pronunciationInfo;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AbbreviationInfo &&
        abbreviation == other.abbreviation &&
        pronunciationInfo == other.pronunciationInfo;
  }

  @override
  int get hashCode => abbreviation.hashCode ^ pronunciationInfo.hashCode;
}

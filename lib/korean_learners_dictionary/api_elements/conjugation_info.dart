part of '../korean_learners_dictionary.dart';

/// (conju_info) > (conjugation_info)
class ConjugationInfo {
  ConjugationInfo({
    required this.conjugation,
    this.pronunciationInfo,
    this.abbreviationInfo,
  });

  factory ConjugationInfo.fromXmlElement(XmlElement data) {
    final conjugationInfo = data.getElement(ApiXmlElement.conjugationInfo.name);
    if (conjugationInfo == null) return ConjugationInfo(conjugation: "");

    var aux = data.getElement(ApiXmlElement.abbreviationInfo.name);
    final abbreviationInfo =
        aux == null ? null : AbbreviationInfo.fromXmlElement(aux);

    final conjugation = conjugationInfo
        .getElement(ApiXmlElement.conjugation.name)!
        .innerText
        .trim();

    aux = conjugationInfo.getElement(ApiXmlElement.pronunciationInfo.name);
    final pronunciationInfo =
        aux == null ? null : PronunciationInfo.fromXmlElement(aux);

    return ConjugationInfo(
      conjugation: conjugation,
      pronunciationInfo: pronunciationInfo,
      abbreviationInfo: abbreviationInfo,
    );
  }

  final String conjugation;
  final PronunciationInfo? pronunciationInfo;
  final AbbreviationInfo? abbreviationInfo;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConjugationInfo &&
        conjugation == other.conjugation &&
        pronunciationInfo == other.pronunciationInfo &&
        abbreviationInfo == other.abbreviationInfo;
  }

  @override
  int get hashCode =>
      conjugation.hashCode ^
      pronunciationInfo.hashCode ^
      abbreviationInfo.hashCode;
}

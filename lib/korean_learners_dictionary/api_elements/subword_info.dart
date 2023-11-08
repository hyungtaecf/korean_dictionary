part of '../korean_learners_dictionary.dart';

/// 부표제어
///
/// (subword_info)
class SubwordInfo {
  SubwordInfo({
    required this.subword,
    required this.subwordUnit,
    required this.reference,
    required this.subsenseInfo,
  });

  factory SubwordInfo.fromXmlElement(XmlElement data) {
    final subword =
        data.getElement(ApiXmlElement.subword.name)!.innerText.trim();
    final subwordUnit =
        data.getElement(ApiXmlElement.subwordUnit.name)!.innerText.trim();
    final reference =
        data.getElement(ApiXmlElement.reference.name)?.innerText.trim();
    final aux = data.getElement(ApiXmlElement.subsenseInfo.name);
    final subsenseInfo = aux == null ? null : SenseInfo.fromXmlElement(aux);
    return SubwordInfo(
      subword: subword,
      subwordUnit: subwordUnit,
      reference: reference,
      subsenseInfo: subsenseInfo,
    );
  }

  final String subword;

  /// 부표제어 구성 단위
  ///
  /// (subword_unit)
  final String subwordUnit;

  /// 참고
  final String? reference;

  /// 부표제어 의미
  ///
  /// (subsense_info)
  final SenseInfo? subsenseInfo;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubwordInfo &&
        subword == other.subword &&
        subwordUnit == other.subwordUnit &&
        reference == other.reference &&
        subsenseInfo == other.subsenseInfo;
  }

  @override
  int get hashCode =>
      subword.hashCode ^
      subwordUnit.hashCode ^
      reference.hashCode ^
      subsenseInfo.hashCode;
}

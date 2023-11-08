part of '../korean_learners_dictionary.dart';

/// 문형
///
/// (pattern_info)
class PatternInfo {
  PatternInfo({
    required this.pattern,
    this.reference,
  });

  factory PatternInfo.fromXmlElement(XmlElement data) {
    final pattern =
        data.getElement(ApiXmlElement.pattern.name)!.innerText.trim();
    final reference =
        data.getElement(ApiXmlElement.reference.name)?.innerText.trim();
    return PatternInfo(
      pattern: pattern,
      reference: reference,
    );
  }

  final String pattern;

  /// (pattern_reference)
  final String? reference;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatternInfo &&
        pattern == other.pattern &&
        reference == other.reference;
  }

  @override
  int get hashCode => pattern.hashCode ^ reference.hashCode;
}

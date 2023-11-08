part of '../korean_learners_dictionary.dart';

/// 용례
///
/// (example_info)
class ExampleInfo {
  ExampleInfo({required this.type, required this.example});

  factory ExampleInfo.fromXmlElement(XmlElement data) {
    final type = data.getElement(ApiXmlElement.type.name)!.innerText.trim();
    final example =
        data.getElement(ApiXmlElement.example.name)!.innerText.trim();
    return ExampleInfo(
      type: type,
      example: example,
    );
  }

  /// 문장, 대화, 구
  final String type;

  final String example;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExampleInfo &&
        type == other.type &&
        example == other.example;
  }

  @override
  int get hashCode => type.hashCode ^ example.hashCode;
}

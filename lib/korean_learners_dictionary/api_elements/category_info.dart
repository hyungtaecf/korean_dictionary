part of '../korean_learners_dictionary.dart';

/// 범주
///
/// (category_info)
class CategoryInfo {
  const CategoryInfo({
    required this.type,
    required this.writtenForm,
    this.reference,
    this.allomorph,
  });

  factory CategoryInfo.fromXmlElement(XmlElement data) {
    final type = data.getElement(ApiXmlElement.type.name)!.innerText.trim();
    final writtenForm =
        data.getElement(ApiXmlElement.writtenForm.name)!.innerText.trim();
    final reference =
        data.getElement(ApiXmlElement.reference.name)?.innerText.trim();
    final allomorph =
        data.getElement(ApiXmlElement.allomorph.name)?.innerText.trim();
    return CategoryInfo(
      type: type,
      writtenForm: writtenForm,
      reference: reference,
      allomorph: allomorph,
    );
  }

  /// e.g. 의미 범주
  final String type;

  /// e.g. 동식물 > 동식물 행위
  ///
  /// (written_form)
  final String writtenForm;

  /// 참고
  final String? reference;

  /// 이형태
  final String? allomorph;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryInfo &&
        type == other.type &&
        writtenForm == other.writtenForm &&
        reference == other.reference &&
        allomorph == other.allomorph;
  }

  @override
  int get hashCode =>
      type.hashCode ^
      writtenForm.hashCode ^
      reference.hashCode ^
      allomorph.hashCode;
}

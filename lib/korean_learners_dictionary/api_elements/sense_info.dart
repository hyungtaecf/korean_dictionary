part of '../korean_learners_dictionary.dart';

/// 의미
///
/// (sense_info)
class SenseInfo {
  SenseInfo({
    required this.definition,
    this.reference,
    this.patternInfo,
    this.relatedInfo,
    this.translations = const {},
    this.examples = const [],
  });
  factory SenseInfo.fromXmlElement(XmlElement data) {
    final definition =
        data.getElement(ApiXmlElement.definition.name)!.innerText.trim();
    final reference =
        data.getElement(ApiXmlElement.reference.name)?.innerText.trim();

    var aux = data.getElement(ApiXmlElement.patternInfo.name);
    final patternInfo = aux == null ? null : PatternInfo.fromXmlElement(aux);

    aux = data.getElement(ApiXmlElement.relatedInfo.name);
    final relatedInfo = aux == null ? null : RelatedInfo.fromXmlElement(aux);

    final translations = data
        .findElements(ApiXmlElement.translation.name)
        .map(Translation.fromXmlElement)
        .toList()
        .asMap()
        .map<TranslationLanguage, DictionaryDefinitionTranslation>(
          (_, translation) => MapEntry(
            TranslationLanguage.fromHangul(translation.language!.hangul)!,
            DictionaryDefinitionTranslation.fromTranslation(translation),
          ),
        );

    final examples = data
        .findElements(ApiXmlElement.exampleInfo.name)
        .map(ExampleInfo.fromXmlElement)
        .toList();

    return SenseInfo(
      definition: definition,
      translations: translations,
      reference: reference,
      patternInfo: patternInfo,
      relatedInfo: relatedInfo,
      examples: examples,
    );
  }

  final String definition;
  final String? reference;
  final PatternInfo? patternInfo;
  final RelatedInfo? relatedInfo;
  final Map<TranslationLanguage, DictionaryDefinitionTranslation> translations;
  final List<ExampleInfo> examples;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SenseInfo &&
        definition == other.definition &&
        // Using MapEquality checkig the map equality it returns false
        // const MapEquality().equals(translations, other.translations)
        const IterableEquality()
            .equals(translations.values, other.translations.values) &&
        reference == other.reference &&
        patternInfo == other.patternInfo &&
        relatedInfo == other.relatedInfo &&
        const ListEquality().equals(examples, other.examples);
  }

  @override
  int get hashCode =>
      definition.hashCode ^
      translations.hashCode ^
      reference.hashCode ^
      patternInfo.hashCode ^
      relatedInfo.hashCode ^
      examples.hashCode;
}

part of '../korean_learners_dictionary.dart';

/// Word meaning.
class Sense {
  const Sense({
    required this.order,
    required this.definition,
    this.translations = const {},
  });
  factory Sense.fromXmlElement(XmlElement data) {
    final order = int.parse(
      data.getElement(ApiXmlElement.senseOrder.name)!.innerText.trim(),
    );
    final definition =
        data.getElement(ApiXmlElement.definition.name)!.innerText.trim();
    final translationEntries =
        data.findElements(ApiXmlElement.translation.name).map(
      (e) {
        final translation = Translation.fromXmlElement(e);
        return MapEntry(translation.language!,
            DictionaryDefinitionTranslation.fromTranslation(translation));
      },
    );
    final translations = {
      for (final entry in translationEntries) entry.key: entry.value,
    };
    print("test");
    return Sense(
      order: order,
      definition: definition,
      translations: translations,
    );
  }

  /// order = index + 1
  factory Sense.fromSenseInfo(
    SenseInfo senseInfo, {
    required int order,
  }) {
    final definition = senseInfo.definition;
    final translations =
        Map<TranslationLanguage, DictionaryDefinitionTranslation>.from(
            senseInfo.translations);
    return Sense(
      order: order,
      definition: definition,
      translations: translations,
    );
  }

  /// Order of the meaning.
  ///
  /// sense_order
  final int order;

  final String definition;
  final Map<TranslationLanguage, DictionaryDefinitionTranslation> translations;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sense &&
        order == other.order &&
        definition == other.definition &&
        const MapEquality().equals(translations, other.translations);
  }

  @override
  int get hashCode =>
      order.hashCode ^ definition.hashCode ^ translations.hashCode;
}

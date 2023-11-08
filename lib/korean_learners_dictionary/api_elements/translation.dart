part of '../korean_learners_dictionary.dart';

class Translation {
  const Translation({
    this.language,
    this.word,
    this.definition,
  });

  factory Translation.fromXmlElement(XmlElement data) {
    final aux = data.getElement(ApiXmlElement.transLang.name)?.innerText.trim();
    final language = aux == null ? null : TranslationLanguage.fromHangul(aux);
    final word =
        data.getElement(ApiXmlElement.transWord.name)?.innerText.trim();
    final definition =
        data.getElement(ApiXmlElement.transDfn.name)?.innerText.trim();
    return Translation(
      language: language,
      word: word,
      definition: definition,
    );
  }

  factory Translation.fromDictionaryDefinitionTranslation(
    DictionaryDefinitionTranslation value, {
    TranslationLanguage? language,
  }) {
    return Translation(
      language: language,
      definition: value.definition,
      word: value.translations?.join(language?.wordSeparator ?? "; "),
    );
  }

  /// Translation language.
  ///
  /// - 영어
  /// - 일본어
  /// - 프랑스어
  /// - 스페인어
  /// - 아랍어
  /// - 몽골어
  /// - 베트남어
  /// - 타이어
  /// - 인도네시아어
  /// - 러시아어
  ///
  /// (trans_lang)
  final TranslationLanguage? language;

  /// Translation text.
  ///
  /// ```markdown
  /// e.g. 하다(1) => do; perform
  /// ```
  ///
  /// (trans_word)
  final String? word;

  /// Translation definition.
  ///
  /// ```markdown
  ///  e.g. 하다(1) => A range within the distance that one can travel to take
  ///  care of certain business and return in one day.
  /// ```
  /// (trans_dfn)
  final String? definition;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Translation &&
        language == other.language &&
        word == other.word &&
        definition == other.definition;
  }

  @override
  int get hashCode => language.hashCode ^ word.hashCode ^ definition.hashCode;
}

part of '../korean_learners_dictionary.dart';

class DictionaryDefinitionTranslation {
  DictionaryDefinitionTranslation({
    this.definition,
    this.translations,
  });

  factory DictionaryDefinitionTranslation.fromTranslation(
    Translation translation,
  ) {
    List<String>? translations;
    var word = translation.word;
    if (word != null) {
      // inside square brackets or parenthesis
      final pattern = RegExp(r'\[.*?\]|\(.*?\)');
      word = word
          // Sometimes extra information is inside square brackets, but with
          //  characters used for separators. So it is best to remove the
          //  extra information than taking the risk of adding translations
          //  with trash (pieces of phrases) to the database.
          .replaceAll(pattern, "");

      // Sometimes translations having comma are separated by the semicolon.
      const primarySeparator = ";";
      final separators = [
        ",",
        ...TranslationLanguage.values
            .map((lang) => lang.wordSeparator)
            .whereType<String>(),
      ];
      final splitRegExp = RegExp(
        (StringBuffer()..writeAll(["[", ...separators, "]"])).toString(),
      );
      // translations = word?.split(pattern) ?? null;
      final primarySplit = word.split(primarySeparator);
      if (primarySplit.length > 1) {
        translations = primarySplit;
      } else {
        translations = word.split(splitRegExp);
      }
      translations = translations
          .map(
            (e) => e.replaceAll("【", " (").replaceAll("】", ") ").trim(),
          )
          .toSet()
          .toList();
    }
    return DictionaryDefinitionTranslation(
      definition: translation.definition,
      translations: translations,
    );
  }

  /// Definition text in the tranlation language.
  String? definition;

  /// Translation texts.
  List<String>? translations;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DictionaryDefinitionTranslation &&
        definition == other.definition &&
        const ListEquality().equals(translations, other.translations);
  }

  @override
  int get hashCode => definition.hashCode ^ translations.hashCode;
}

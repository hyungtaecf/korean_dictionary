part of '../korean_learners_dictionary.dart';

/// (original_language_info)
class OriginalLanguageInfo {
  OriginalLanguageInfo({
    required this.originalLanguage,
    required this.languageType,
  });

  factory OriginalLanguageInfo.fromXmlElement(
    XmlElement data, {
    required String word,
    required WordType wordType,
  }) {
    var originalLanguage =
        data.getElement(ApiXmlElement.originalLanguage.name)!.innerText.trim();
    final languageType =
        data.getElement(ApiXmlElement.languageType.name)!.innerText.trim();

    // Remove repeated hanja characters if the korean word doesn't have repeated
    //  characters. This is because when a hanja has multiple meanings for this
    //  word, the hanja will appear multiple times in the data from the API.
    if (word.length != originalLanguage.length &&
        {"한자", "한자어"}.contains(languageType)) {
      final hasRepeatedHanjaCharacters = originalLanguage.characters.any(
        (ch) => originalLanguage.characters.where((e) => e == ch).length > 1,
      );
      if (hasRepeatedHanjaCharacters) {
        if (wordType == WordType.hybrid) {
          final hasRepeatedKoreanCharacters = word.characters
              .any((ch) => word.characters.where((e) => e == ch).length > 1);
          if (!hasRepeatedKoreanCharacters) {
            for (var i = 0; i < originalLanguage.length; i++) {
              final ch = originalLanguage[i];
              for (var j = i + 1; j < originalLanguage.length; j++) {
                if (ch == originalLanguage[j]) {
                  originalLanguage = originalLanguage.substring(0, j) +
                      (j + 1 < originalLanguage.length
                          ? originalLanguage.substring(j + 1)
                          : "");
                }
              }
            }
          }
        } else {
          // Check character by character to be more precise.
          for (var i = 1; i < originalLanguage.length; i++) {
            final ch = originalLanguage[i - 1];
            final didWordEnd = word.length <= i;
            if (ch == originalLanguage[i] &&
                (didWordEnd || word[i - 1] != word[i])) {
              originalLanguage = originalLanguage.substring(0, i) +
                  (i + 1 < originalLanguage.length
                      ? originalLanguage.substring(i + 1)
                      : "");
            }
          }
        }
      }
    }
    return OriginalLanguageInfo(
      originalLanguage: originalLanguage,
      languageType: languageType,
    );
  }

  /// Word (text) in the original language.
  ///
  /// (original_language)
  final String originalLanguage;

  /// Language
  ///
  /// 고유어, 한자, 영어, 독일어, ...
  ///
  /// (language_type)
  final String languageType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OriginalLanguageInfo &&
        originalLanguage == other.originalLanguage &&
        languageType == other.languageType;
  }

  @override
  int get hashCode => originalLanguage.hashCode ^ languageType.hashCode;
}

// ignore_for_file: curly_braces_in_flow_control_structures

part of '../korean_learners_dictionary.dart';

/// Item coming from api/view
class ViewItem extends Item {
  const ViewItem({
    required this.wordUnit,
    required this.wordType,
    required super.word,
    required super.pos,
    required super.targetCode,
    required super.supNo,
    required super.link,
    this.pronunciations = const [],
    this.origins = const [],
    this.conjugations = const [],
    this.abbreviations = const [],
    this.references = const [],
    this.categories = const [],
    this.derivatives = const [],
    this.senses = const [],
    this.subwords = const [],
    super.wordGrade,
  });

  /// "channel" xml element.
  factory ViewItem.fromXmlElement(XmlElement data) {
    final item = data.findAllElements(ApiXmlElement.item.name).first;
    final link = data.getElement(ApiXmlElement.link.name)!.innerText.trim();
    final targetCode = int.parse(
      item.getElement(ApiXmlElement.targetCode.name)!.innerText.trim(),
    );
    final wordInfo = item.getElement(ApiXmlElement.wordInfo.name)!;
    final word = wordInfo.getElement(ApiXmlElement.word.name)!.innerText.trim();
    final supNo = int.parse(
      wordInfo.getElement(ApiXmlElement.supNo.name)!.innerText.trim(),
    );
    String? aux = wordInfo.getElement(ApiXmlElement.pos.name)!.innerText.trim();
    final pos = PartOfSpeech.fromHangul(aux);
    aux = wordInfo.getElement(ApiXmlElement.wordGrade.name)?.innerText.trim();
    final wordGrade = WordGrade.fromHangul(aux ?? '');
    aux = wordInfo.getElement(ApiXmlElement.wordUnit.name)!.innerText.trim();
    final wordUnit = WordUnit.fromHangul(aux)!;
    aux = wordInfo.getElement(ApiXmlElement.wordType.name)!.innerText.trim();
    final wordType = WordType.fromHangul(aux)!;
    final pronunciations = wordInfo
        .findElements(ApiXmlElement.pronunciationInfo.name)
        .map(PronunciationInfo.fromXmlElement)
        .toList();
    final origins = wordInfo
        .findElements(ApiXmlElement.originalLanguageInfo.name)
        .map(
          (e) => OriginalLanguageInfo.fromXmlElement(
            e,
            word: word,
            wordType: wordType,
          ),
        )
        .toList();
    final conjugations = wordInfo
        .findElements(ApiXmlElement.conjuInfo.name)
        .map(ConjugationInfo.fromXmlElement)
        .toList()
      ..removeWhere((e) => e.conjugation.isEmpty);
    final abbreviations = wordInfo
        .findElements(ApiXmlElement.abbreviationInfo.name)
        .map(AbbreviationInfo.fromXmlElement)
        .toList();
    final references = wordInfo
        .findElements(ApiXmlElement.refInfo.name)
        .map(ReferenceInfo.fromXmlElement)
        .toList();
    final categories = wordInfo
        .findElements(ApiXmlElement.categoryInfo.name)
        .map(CategoryInfo.fromXmlElement)
        .toList();
    final derivatives = wordInfo
        .findElements(ApiXmlElement.derInfo.name)
        .map(DerivativeInfo.fromXmlElement)
        .toList();
    final senses = wordInfo
        .findElements(ApiXmlElement.senseInfo.name)
        .map(SenseInfo.fromXmlElement)
        .toList();
    final subwords = wordInfo
        .findElements(ApiXmlElement.subwordInfo.name)
        .map(SubwordInfo.fromXmlElement)
        .toList();

    return ViewItem(
      targetCode: targetCode,
      word: word,
      supNo: supNo,
      pos: pos,
      link: link,
      wordGrade: wordGrade,
      wordUnit: wordUnit,
      wordType: wordType,
      origins: origins,
      pronunciations: pronunciations,
      abbreviations: abbreviations,
      references: references,
      categories: categories,
      conjugations: conjugations,
      derivatives: derivatives,
      senses: senses,
      subwords: subwords,
    );
  }

  /// 구성 단위
  ///
  /// Response: 단어, 구, 문법‧표현
  ///
  /// (word_unit)
  final WordUnit wordUnit;

  /// 고유어 여부
  ///
  /// Response: 고유어, 한자어, 외래어, 혼종어
  ///
  /// (word_type)
  final WordType wordType;

  final List<AbbreviationInfo> abbreviations;
  final List<ReferenceInfo> references;
  final List<CategoryInfo> categories;
  final List<PronunciationInfo> pronunciations;
  final List<ConjugationInfo> conjugations;
  final List<OriginalLanguageInfo> origins;
  final List<DerivativeInfo> derivatives;
  final List<SenseInfo> senses;
  final List<SubwordInfo> subwords;

  /// Add other translations from other ViewItem objects.
  void addOtherSenseTranslations(Iterable<ViewItem> iterable) {
    for (final sense in senses)
      for (final item in iterable) {
        final other =
            item.senses.firstWhere((e) => e.definition == sense.definition);
        sense.translations.addAll(other.translations);
      }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ViewItem &&
        targetCode == other.targetCode &&
        supNo == other.supNo &&
        link == other.link &&
        wordGrade == other.wordGrade &&
        word == other.word &&
        pos == other.pos &&
        wordUnit == other.wordUnit &&
        wordType == other.wordType &&
        const ListEquality().equals(pronunciations, other.pronunciations) &&
        const ListEquality().equals(origins, other.origins) &&
        const ListEquality().equals(conjugations, other.conjugations) &&
        const ListEquality().equals(abbreviations, other.abbreviations) &&
        const ListEquality().equals(references, other.references) &&
        const ListEquality().equals(categories, other.categories) &&
        const ListEquality().equals(derivatives, other.derivatives) &&
        const ListEquality().equals(senses, other.senses) &&
        const ListEquality().equals(subwords, other.subwords);
  }

  @override
  int get hashCode =>
      targetCode.hashCode ^
      supNo.hashCode ^
      link.hashCode ^
      wordGrade.hashCode ^
      word.hashCode ^
      pos.hashCode ^
      wordUnit.hashCode ^
      wordType.hashCode ^
      pronunciations.hashCode ^
      origins.hashCode ^
      conjugations.hashCode ^
      abbreviations.hashCode ^
      references.hashCode ^
      categories.hashCode ^
      derivatives.hashCode ^
      senses.hashCode ^
      subwords.hashCode;
}

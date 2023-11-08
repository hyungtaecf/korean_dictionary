part of '../korean_learners_dictionary.dart';

/// Item coming from api/search
class SearchItem extends Item {
  const SearchItem({
    required this.senses,
    required super.word,
    required super.pos,
    required super.targetCode,
    required super.supNo,
    required super.link,
    this.origin,
    this.pronunciation,
    super.wordGrade,
  });

  /// "item" xml element.
  factory SearchItem.fromXmlElement(XmlElement data) {
    final targetCode = int.parse(
      data.getElement(ApiXmlElement.targetCode.name)!.innerText.trim(),
    );
    final word = data.getElement(ApiXmlElement.word.name)!.innerText.trim();
    final supNo =
        int.parse(data.getElement(ApiXmlElement.supNo.name)!.innerText.trim());
    final senses = data
        .findElements(ApiXmlElement.sense.name)
        .map(Sense.fromXmlElement)
        .toList();
    final link = data.getElement(ApiXmlElement.link.name)!.innerText.trim();
    final origin = data.getElement(ApiXmlElement.origin.name)?.innerText.trim();
    var aux = data.getElement(ApiXmlElement.wordGrade.name)?.innerText.trim();
    final wordGrade = WordGrade.fromHangul(aux ?? '');
    final pronunciation =
        data.getElement(ApiXmlElement.pronunciation.name)?.innerText.trim();
    aux = data.getElement(ApiXmlElement.pos.name)!.innerText.trim();
    final pos = PartOfSpeech.fromHangul(aux);
    return SearchItem(
      targetCode: targetCode,
      word: word,
      supNo: supNo,
      senses: senses,
      pos: pos,
      link: link,
      origin: origin,
      wordGrade: wordGrade,
      pronunciation: pronunciation,
    );
  }
  factory SearchItem.fromViewItem(
    ViewItem viewItem, {
    TranslationLanguage? translationLanguage,
  }) {
    final targetCode = viewItem.targetCode;
    final word = viewItem.word;
    final supNo = viewItem.supNo;
    final pos = viewItem.pos;
    final link = viewItem.link;

    String? origin = viewItem.origins.map((e) => e.originalLanguage).join();
    if (origin.isEmpty) origin = null;

    final wordGrade = viewItem.wordGrade;

    String? pronunciation =
        viewItem.pronunciations.map((e) => e.pronunciation).join("/");
    if (pronunciation.isEmpty) pronunciation = null;

    final senses = viewItem.senses
        .mapIndexed(
          (index, senseInfo) => Sense.fromSenseInfo(
            senseInfo,
            order: index + 1,
          ),
        )
        .toList();
    return SearchItem(
      targetCode: targetCode,
      word: word,
      supNo: supNo,
      pos: pos,
      link: link,
      wordGrade: wordGrade,
      origin: origin,
      pronunciation: pronunciation,
      senses: senses,
    );
  }

  /// Chinese characters.
  final String? origin;

  /// Pronunciation of the word.
  final String? pronunciation;

  /// Word meanings.
  ///
  /// All of them appear as siblings in the XML at the same level as the other
  /// fields of this class.
  final List<Sense> senses;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchItem &&
        targetCode == other.targetCode &&
        word == other.word &&
        supNo == other.supNo &&
        pos == other.pos &&
        link == other.link &&
        wordGrade == other.wordGrade &&
        origin == other.origin &&
        pronunciation == other.pronunciation &&
        const ListEquality().equals(senses, other.senses);
  }

  @override
  int get hashCode =>
      targetCode.hashCode ^
      word.hashCode ^
      supNo.hashCode ^
      pos.hashCode ^
      link.hashCode ^
      wordGrade.hashCode ^
      origin.hashCode ^
      pronunciation.hashCode ^
      senses.hashCode;
}

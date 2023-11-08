library korean_learners_dictionary;

import 'package:characters/characters.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:korean_dictionary/korean_dictionary.dart';
import 'package:xml/xml.dart';

part 'api_elements/util/linkeable.dart';
part 'api_elements/dictionary_definition_translation.dart';
part 'api_elements/translation.dart';
part 'api_elements/abbreviation_info.dart';
part 'api_elements/category_info.dart';
part 'api_elements/conjugation_info.dart';
part 'api_elements/derivative_info.dart';
part 'api_elements/example_info.dart';
part 'api_elements/multimedia_info.dart';
part 'api_elements/item.dart';
part 'api_elements/original_language_info.dart';
part 'api_elements/pattern_info.dart';
part 'api_elements/pronunciation_info.dart';
part 'api_elements/reference_info.dart';
part 'api_elements/related_info.dart';
part 'api_elements/search_item.dart';
part 'api_elements/sense_info.dart';
part 'api_elements/sense.dart';
part 'api_elements/subword_info.dart';
part 'api_elements/view_item.dart';
part 'enums/api_xml_element.dart';
part 'enums/method.dart';
part 'enums/pos.dart';
part 'enums/sort.dart';
part 'enums/translation_language.dart';
part 'enums/word_grade.dart';
part 'enums/word_type.dart';
part 'enums/word_unit.dart';

/// Helper class to access the Korean Learners Dictionary API by the National
/// Institute of Korean Language.
class KoreanLearnersDictionary extends Dictionary {
  const KoreanLearnersDictionary({required super.apiKey})
      : super(subdomain: "krdict");

  /// API query under https://krdict.korean.go.kr/api/search
  ///
  /// [start] - 검색의 시작 번호.
  ///
  /// [num] - 검색 결과 출력 건수.
  ///
  /// [advanced] - 자세히찾기 여부. y일 경우 번역 언어 변수가 적용된다.
  ///
  /// [letterStart] - 음절 수 시작.
  ///
  /// [letterEnd] - 음절 수 끝.
  Future<Iterable<SearchItem>> search(
    String queryText, {
    Iterable<TranslationLanguage>? transLang,
    Sort? sort,
    Iterable<PartOfSpeech>? pos,
    Iterable<WordGrade>? level,
    SearchMethod? method,
    WordUnit? wordUnit,
    WordType? wordtype,
    int start = 1,
    int num = 10,
    // (hyungtaecf) I couldn't find any difference in the results when toggling
    //  "advanced". If anyone finds any difference please let me know.
    bool advanced = false,
    int letterStart = 1,
    int? letterEnd,
  }) async {
    assert(queryText.isNotEmpty, "A query text should be provided.");
    assert(start > 0 && start <= 1000, "Invalid [start] value.");
    assert(num >= 10 && num <= 100, "Invalid [num] value.");
    assert(letterStart > 0, "Invalid [letterStart] value.");
    assert(letterEnd == null || letterEnd > 0, "Invalid [letterEnd] value.");
    const apiPath = "/api/search";
    final headers = <String, String>{};
    final uri = Uri.https(baseUrl, apiPath, <String, String>{
      ..._getBaseQueryParameters(queryText, transLang),
      if (sort != null) "sort": sort.name,
      if (pos != null) "pos": pos.map<int>((e) => e.code).join(','),
      if (level != null) "level": level.map<String>((e) => e.req).join(','),
      if (method != null) "method": method.name,
      if (wordUnit != null) "type1": wordUnit.name,
      if (wordtype != null) "type2": wordtype.name,
      if (start > 1) "start": "$start",
      "num": "$num",
      if (advanced) "advanced": "y", // yes
      if (letterStart > 1) "letter_s": "$letterStart",
      if (letterEnd != null) "letter_e": "$letterEnd",
      // TODO(hyungtaecf): Implement other parameters (part, target, lang,
      //  multimedia, sense_cat, subject_cat)
    });
    final response = await http.get(uri, headers: headers);
    final xml = XmlDocument.parse(response.body);
    return xml
        .findAllElements(ApiXmlElement.item.name)
        .map(SearchItem.fromXmlElement);
  }

  /// API query under https://krdict.korean.go.kr/api/view
  ///
  /// [queryText]:
  /// - method 입력 값이 'word_info' 경우 어휘 정보 입력 - e.g. 나무0
  /// - method 입력 값이 'target_code'일 경우 대상 코드 입력 - e.g. 32750
  Future<ViewItem> view(
    Object queryText, {
    ViewMethod method = ViewMethod.targetCode,
    Iterable<TranslationLanguage>? transLang,
  }) async {
    final q = queryText.toString();
    assert(q.isNotEmpty, "A query text should be provided.");
    const apiPath = "/api/view";
    final headers = <String, String>{};
    final uri = Uri.https(baseUrl, apiPath, <String, String>{
      ..._getBaseQueryParameters(q, transLang),
      "method": method.name,
    });
    final response = await http.get(uri, headers: headers);
    final xml = XmlDocument.parse(response.body)
        .findAllElements(ApiXmlElement.channel.name)
        .first;
    return ViewItem.fromXmlElement(xml);
  }

  Map<String, dynamic> _getBaseQueryParameters(
    String queryText, [
    Iterable<TranslationLanguage>? transLang,
  ]) =>
      <String, String>{
        "key": apiKey,
        "q": queryText,
        if (transLang != null) ...{
          "translated": "y", // yes
          "trans_lang": transLang.map<int>((e) => e.code).join(','),
        },
      };
}

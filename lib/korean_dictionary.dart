import 'korean_learners_dictionary/korean_learners_dictionary.dart';
export 'korean_learners_dictionary/korean_learners_dictionary.dart';

// For now this package only supports the Korean Learners Dictionary API but, in
//  the future, more dictionary APIs from the National Institute of Korean
//  Language can be added to this package here. This file is an umbrella for all
//  those APIs.
// Other dictionary APIs that could potentially be integrated are:
//  - 표준국어대사전 (standard dictionary)
//  - 우리말샘 (open dictionary)

abstract class Dictionary {
  const Dictionary({required this.apiKey, required this.subdomain});
  static KoreanLearnersDictionary koreanLearners({required String apiKey}) =>
      KoreanLearnersDictionary(apiKey: apiKey);

  final String apiKey;
  final String subdomain;

  String get baseUrl => "$subdomain.korean.go.kr";
}

import 'package:korean_dictionary/korean_dictionary.dart';

Future<void> main() async {
  const apiKey = 'YOUR_API_KEY';
  final dict = Dictionary.koreanLearners(apiKey: apiKey);

  // Use try-catch block to handle eventual http request errors
  try {
    // Use the "search" API method to look for Korean words.
    final result = await dict.search(
      "한국어",
      // You don't need to especify translation languages if you just need
      //  information in Korean language.
      transLang: {TranslationLanguage.english},
    );
    for (final item in result) {
      // Even just with the search method you can already get many useful
      //  information like the word translations and definitions
      final translation = item.senses.first.translations.values.first;
      // prints translations (see prints below)
      print(translation.translations);
      // prints definition (see prints below)
      print(translation.definition);

      // You can get more information of the words with the "view" API method:
      final detailedInfo = await dict.view(
        item.targetCode,
        transLang: {TranslationLanguage.english},
      );
      // e.g. See a sentence example
      final anExemple = detailedInfo.senses.first.examples.first.example;
      // prints first sentence example (see prints below)
      print(anExemple);
    }
  } catch (e) {
    print("$e");
  }
}

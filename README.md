Korean dictionary API - Interface for the open API services that are provided by the National Institute of Korean Language.

## Features

- Search over 50,000 words (dictionary entries).
- Word translations and definitions available in many languages (English, Japanese, French, Spanish, Arabic, Mongolian, Vietnamese, Thai, Indonesian, Russian, Chinese).
- Get detailed information: Definitions, examples, conjugations, patterns, pronunciation, multimedia and more!

## Getting started

1. This package interfaces the **한국어기초사전 (Korean Learners' Dictionary) Open API**. So, you must get an API key by registering on the official API website: [Register](https://krdict.korean.go.kr/openApi/openApiRegister)
2. In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
  korean_dictionary: <latest_version>
```

## Usage

There are many options in this API but let's see simple examples of usage:

```dart
const apiKey = 'YOUR_API_KEY';
final dict = Dictionary.koreanLearners(apiKey: apiKey);

// Use try-catch block to handle eventual http request errors
try {
// Use the "search" API method to look for Korean words.
final result = await dict.search(
    "나무",
    // You don't need to especify translation languages if you just need
    //  information in Korean language.
    transLang: {TranslationLanguage.english},
);
for (final item in result) {
    // Even just with the search method you can already get many useful
    //  information like the word translations and definitions
    final translation = item.senses.first.translation!;
    // prints translations (see prints below)
    print(translation.word);
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
    debugPrint("$e");
}
```

The previous example prints:

```
[tree]
A plant with a hard stem, branches and leaves.
농부들은 한낮의 햇볕을 피해 나무 그늘 아래에서 낮잠을 청했다.

[scold, rebuke]
To scold someone for his/her fault in a way that he/she will understand well.
한 할아버지가 젊은이들의 무례함을 점잖게 나무라셨다.

[woodcutter; woodman; lumberjack]
(archaic) A person who makes a living by cutting and selling firewood.
나무꾼 총각은 비가 오나 눈이 오나 하루도 빠짐없이 산에 나무를 하러 갔다.

...
```

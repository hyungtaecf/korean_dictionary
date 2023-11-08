part of '../korean_learners_dictionary.dart';

/// Utility enum to get the XML element names for the API avoiding typos.
enum ApiXmlElement {
  abbreviation("abbreviation"),
  abbreviationInfo("abbreviation_info"),
  allomorph("allomorph"),
  categoryInfo("category_info"),
  channel("channel"),
  conjuInfo("conju_info"),
  conjugationInfo("conjugation_info"),
  conjugation("conjugation"),
  definition("definition"),
  derInfo("der_info"),
  example("example"),
  exampleInfo("example_info"),
  item("item"),
  lable("lable"),
  languageType("language_type"),
  link("link"),
  linkTargetCode("link_target_code"),
  linkType("link_type"),
  order("order"),
  origin("origin"),
  originalLanguage("original_language"),
  originalLanguageInfo("original_language_info"),
  pattern("pattern"),
  patternInfo("pattern_info"),
  pos("pos"),
  pronunciation("pronunciation"),
  pronunciationInfo("pronunciation_info"),
  reference("reference"),
  relatedInfo("related_info"),
  refInfo("ref_info"),
  sense("sense"),
  senseInfo("sense_info"),
  senseOrder("sense_order"),
  subsenseInfo("subsense_info"),
  subword("subword"),
  subwordInfo("subword_info"),
  subwordUnit("subword_unit"),
  supNo("sup_no"),
  targetCode("target_code"),
  transDfn("trans_dfn"),
  transLang("trans_lang"),
  translation("translation"),
  translations("translations"),
  transWord("trans_word"),
  type("type"),
  word("word"),
  wordGrade("word_grade"),
  wordInfo("word_info"),
  wordType("word_type"),
  wordUnit("word_unit"),
  writtenForm("written_form");

  const ApiXmlElement(this.name);

  final String name;
}
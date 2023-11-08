part of '../korean_learners_dictionary.dart';

/// (multimedia_info)
class MultimediaInfo {
  MultimediaInfo({
    required this.lable,
    required this.type,
    required this.link,
  });

  factory MultimediaInfo.fromXmlElement(XmlElement data) {
    final lable = data.getElement(ApiXmlElement.lable.name)!.innerText.trim();
    final type = data.getElement(ApiXmlElement.type.name)!.innerText.trim();
    final link = data.getElement(ApiXmlElement.link.name)!.innerText.trim();
    return MultimediaInfo(
      lable: lable,
      type: type,
      link: link,
    );
  }

  final String lable;
  final String type;
  final String link;
}

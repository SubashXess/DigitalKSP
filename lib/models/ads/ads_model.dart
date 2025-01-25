import '../../constants/urls.dart';

class AdsModel {
  final String id;
  final String addType;
  final String blogId;
  final String title1;
  final String image1;
  final String title2;
  final String image2;
  final String link1;
  final String link2;
  final String textAd;
  final String textLink;

  AdsModel({
    required this.id,
    required this.addType,
    required this.blogId,
    required this.title1,
    required this.image1,
    required this.title2,
    required this.image2,
    required this.link1,
    required this.link2,
    required this.textAd,
    required this.textLink,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    String processImagePath(String? path) {
      if (path == null || path.isEmpty) return '';
      if (path.startsWith('../')) {
        path = path.substring(3);
      }
      return '${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$path';
    }

    return AdsModel(
      id: json["id"],
      addType: json["add_type"],
      blogId: json["blog_id"],
      title1: json["title_1"],
      image1: processImagePath(json["image_1"]),
      title2: json["title_2"],
      image2: processImagePath(json["image_2"]),
      link1: json["link_1"],
      link2: json["link_2"],
      textAd: json["text_ad"],
      textLink: json["text_link"],
    );
  }

  static List<AdsModel> adsFromJson(Map<String, dynamic> jsonData) {
    final categories = jsonData['data']['ads'] as List;
    return categories.map((data) => AdsModel.fromJson(data)).toList();
  }
}

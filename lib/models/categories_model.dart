import '../constants/urls.dart';

class CategoriesModel {
  final String name;
  final String desc;
  final String image;
  // final int count;

  const CategoriesModel({
    required this.name,
    required this.desc,
    required this.image,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['image'] ?? '';

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';
    return CategoriesModel(
      name: json['name'],
      desc: json['about'],
      image: imageUrl,
      // count: int.tryParse(json['blog_count'].toString()) ?? 0,
    );
  }

  static List<CategoriesModel> categoriesFromJson(
      Map<String, dynamic> jsonData) {
    final categories = jsonData['data']['categories'] as List;
    return categories.map((data) => CategoriesModel.fromJson(data)).toList();
  }

  // static List<CategoriesModel> categoriesFromJson(String str) =>
  //     List<CategoriesModel>.from(
  //         json.decode(str).map((data) => CategoriesModel.fromJson(data)));
}

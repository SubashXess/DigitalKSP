class CategoriesModel {
  final String name;
  final int count;

  const CategoriesModel({required this.name, required this.count});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        name: json['category_name'],
        count: int.tryParse(json['blog_count'].toString()) ?? 0,
      );

  static List<CategoriesModel> categoriesFromJson(
      Map<String, dynamic> jsonData) {
    final categories = jsonData['data']['categories'] as List;
    return categories.map((data) => CategoriesModel.fromJson(data)).toList();
  }

  // static List<CategoriesModel> categoriesFromJson(String str) =>
  //     List<CategoriesModel>.from(
  //         json.decode(str).map((data) => CategoriesModel.fromJson(data)));
}

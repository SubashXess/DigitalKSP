import 'dart:convert';
import 'package:digitalksp/constants/urls.dart';
import 'package:http/http.dart' as http;
import '../models/blogs/blog_models.dart';
import '../models/categories_model.dart';

class HttpRequest {
  HttpRequest._();
  static final HttpRequest _instance = HttpRequest._();
  static HttpRequest get instance => _instance;

  // Get Categories
  Future<List<CategoriesModel>> getCategory() async {
    final Uri url = Uri.parse(ApiRequest.instance.apiGetCategories);

    try {
      final response = await http.get(url, headers: <String, String>{
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return CategoriesModel.categoriesFromJson(jsonData).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  // Fetch Blogs

  Future<List<BlogModels>> getIndividualCategoryBlog(
      {required String category, int limit = 10, int page = 1}) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiRequest.instance.apiGetBlogByIndCategory}?category=$category&limit=$limit&page=$page'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return BlogModels.blogsFromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}

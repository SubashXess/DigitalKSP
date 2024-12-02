import 'dart:convert';
import 'package:digitalksp/constants/urls.dart';
import 'package:http/http.dart' as http;

import '../models/blogs/blog_models.dart';

class PostRepository {
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

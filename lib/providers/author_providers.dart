import 'dart:convert';
import 'package:digitalksp/models/author_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class AuthorProviders extends ChangeNotifier {
  List<AuthorModels> _author = [];
  List<AuthorModels> get author => _author;

  List<BlogByAuthorModel> _blogByAuthor = [];
  List<BlogByAuthorModel> get blogByAuthor => _blogByAuthor;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  Future<void> getAuthors() async {
    final Uri url =
        Uri.parse('${ApiRequest.BASE_URL}${ApiRequest.API_GET_AUTHORS}');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        print(jsonData);

        _author = AuthorModels.authorsFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getBlogByAuthor(String authorId) async {
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_BLOG_BY_AUTHOR}?author=$authorId');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _blogByAuthor =
            BlogByAuthorModel.blogByAuthorFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  void selectCategory(String category) {
    if (_selectedCategory == category) {
      _selectedCategory = null;
    } else {
      _selectedCategory = category;
    }
    notifyListeners();
  }

  List<BlogByAuthorModel> getFilteredBlogs() {
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      return _blogByAuthor;
    } else {
      return _blogByAuthor
          .where((blog) => blog.category == _selectedCategory)
          .toList();
    }
  }
}

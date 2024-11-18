import 'dart:convert';
import 'package:digitalksp/models/author/author_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/blogs/blog_models.dart';

class AuthorProviders extends ChangeNotifier {
  List<AuthorModels> _author = [];
  List<AuthorModels> get author => _author;

  List<AuthorModels> _authorById = [];
  List<AuthorModels> get authorById => _authorById;

  AuthorBlogCategoriesModel? _authorBlogCategories;
  AuthorBlogCategoriesModel? get authorBlogCategories => _authorBlogCategories;

  List<BlogModels> _blogByAuthor = [];
  List<BlogModels> get blogByAuthor => _blogByAuthor;

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

        _author = AuthorModels.authorsFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getAuthorById(String id) async {
    _authorById = [];
    final Uri url =
        Uri.parse('${ApiRequest.BASE_URL}${ApiRequest.API_GET_AUTHORS}?id=$id');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _authorById = AuthorModels.authorsFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getAuthorBlogCategories(String authorId) async {
    _authorBlogCategories = null;
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_AUTHOR_BLOG_CATEGORIES}?author=$authorId');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _authorBlogCategories = AuthorBlogCategoriesModel.fromJson(jsonData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getBlogByAuthor(String authorId) async {
    _blogByAuthor = [];
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_BLOG_BY_AUTHOR}?author=$authorId');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _blogByAuthor = BlogModels.blogsFromJson(jsonData).toList();

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getBlogByCategory(String authorId, String category) async {
    _blogByAuthor = [];
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_BLOG_BY_AUTHOR}?author=$authorId&category=$category');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _blogByAuthor = BlogModels.blogsFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  void selectCategory(String category, String authorId) {
    if (_selectedCategory == category) {
      _selectedCategory = null;
    } else {
      _selectedCategory = category;
    }

    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      getBlogByCategory(authorId, _selectedCategory!);
    } else {
      getBlogByAuthor(authorId);
    }
    notifyListeners();
  }

  List<BlogModels> getFilteredBlogs() {
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      return _blogByAuthor;
    } else {
      return _blogByAuthor
          .where((blog) => blog.category == _selectedCategory)
          .toList();
    }
  }
}

import 'dart:convert';
import 'package:digitalksp/models/blogs/blog_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/blog_post_model.dart';

class BlogProviders extends ChangeNotifier {
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  List<BlogContentModel> _blogContent = [];
  List<BlogContentModel> get blogContent => _blogContent;

  BlogPostModel? _blogPostModel;
  BlogPostModel? get blogPostModel => _blogPostModel;

  // Normal, Front Banner, Recent, Latest, Most Popular, Featured

  List<BlogModels> _normalBlogModel = [];
  List<BlogModels> get normalBlogModel => _normalBlogModel;

  List<BlogModels> _frontBannerBlogModel = [];
  List<BlogModels> get frontBannerBlogModel => _frontBannerBlogModel;

  List<BlogModels> _recentBlogModel = [];
  List<BlogModels> get recentBlogModel => _recentBlogModel;

  List<BlogModels> _latestBlogModel = [];
  List<BlogModels> get latestBlogModel => _latestBlogModel;

  List<BlogModels> _popularBlogModel = [];
  List<BlogModels> get popularBlogModel => _popularBlogModel;

  List<BlogModels> _featuredBlogModel = [];
  List<BlogModels> get featuredBlogModel => _featuredBlogModel;

  List<BlogModels> _blogByIndCategory = [];
  List<BlogModels> get blogByIndCategory => _blogByIndCategory;

  List<Map<String, dynamic>> _blogCategoryModel = [];
  List<Map<String, dynamic>> get blogCategoryModel => _blogCategoryModel;

  List<BlogModels> _blogByTypeModel = [];
  List<BlogModels> get blogByTypeModel => _blogByTypeModel;

  final Map<String, List<BlogModels>> _blogTypeMap = {
    'Normal': [],
    'Front Banner': [],
    'Recent': [],
    'Latest': [],
    'Most Popular': [],
    'Featured': []
  };

  Future<void> getBlogs(
      {required String type, int limit = 10, int page = 1}) async {
    final Uri url = Uri.parse(
        '${ApiRequest.instance.apiGetBlogs}?type=$type&limit=$limit&page=$page');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Normal, Front Banner, Recent, Latest, Most Popular, Featured
        final List<BlogModels> blogs = BlogModels.blogsFromJson(jsonData);

        if (_blogTypeMap.containsKey(type)) {
          _blogTypeMap[type]?.addAll(blogs);
        } else {
          throw Exception('Unexpected blog type: $type');
        }

        _assignBlogsToType();

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occurred: $err');
    }
  }

  void _assignBlogsToType() {
    _normalBlogModel = _blogTypeMap['Normal'] ?? [];
    _frontBannerBlogModel = _blogTypeMap['Front Banner'] ?? [];
    _recentBlogModel = _blogTypeMap['Recent'] ?? [];
    _latestBlogModel = _blogTypeMap['Latest'] ?? [];
    _popularBlogModel = _blogTypeMap['Most Popular'] ?? [];
    _featuredBlogModel = _blogTypeMap['Featured'] ?? [];
  }

  Future<void> getBlogContent(String blogId) async {
    _blogContent = [];
    _blogPostModel = null;

    final Uri url =
        Uri.parse('${ApiRequest.instance.apiGetBlogPost}?blog_id=$blogId');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // List<BlogContentModel> blogContent = jsonData['data']['blog_content'];
        // BlogModels blog = jsonData['data']['blog_data'];
        // AuthorModels author = jsonData['data']['author_details'];

        final content = jsonData['data'];

        _blogPostModel = BlogPostModel.fromJson(content);

        // _blogContent =
        //     content.map((data) => BlogContentModel.fromJson(data)).toList();

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getBlogByCategory({String? category, String limit = '8'}) async {
    _blogCategoryModel = [];
    category ??= '';

    final Uri url = Uri.parse(
        '${ApiRequest.instance.apiGetBlogByCategory}?categories=$category&limit=$limit');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        final category = BlogCategoryModel.fromJson(jsonData);

        category.categories.forEach((category, blog) {
          _blogCategoryModel.add(
            {
              'category': category,
              'blogs': blog
                  .map((blogData) => BlogModels.fromJson(blogData))
                  .toList(),
            },
          );
        });

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  String? _currentCategory;

  Future<void> getBlogByIndCategory(
      {String? category, String limit = '10', String page = '1'}) async {
    if (_currentCategory != category) {
      _blogByIndCategory.clear();
      _currentCategory = category;
    }

    final Uri url = Uri.parse(
        '${ApiRequest.instance.apiGetBlogByIndCategory}?category=$category&limit=$limit&page=$page');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<BlogModels> newBlogs = BlogModels.blogsFromJson(jsonData);
        _blogByIndCategory.addAll(newBlogs);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occurred $err');
    }
  }

  Future<void> getBlogByType(
      {required String type, String limit = '10', String page = '1'}) async {
    if (page == '1') {
      _blogByTypeModel = [];
    }

    final Uri url = Uri.parse(
        '${ApiRequest.instance.apiGetBlogs}?type=$type&limit=$limit&page=$page');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        final List<BlogModels> newBlogs = BlogModels.blogsFromJson(jsonData);

        // _blogByTypeModel.addAll(newBlogs);

        if (page == '1') {
          _blogByTypeModel = newBlogs;
        } else {
          _blogByTypeModel.addAll(newBlogs);
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occurred $err');
    }
  }

  void selectCategory(String? value) {}
}

import 'dart:convert';
import 'package:digitalksp/models/blogs/blog_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/blog_post_model.dart';

class BlogProviders extends ChangeNotifier {
  // List<BlogModels> _blogModel = [];
  // List<BlogModels> get blogModel => _blogModel;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  List<BlogContentModel> _blogContent = [];
  List<BlogContentModel> get blogContent => _blogContent;

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

  final Map<String, List<BlogModels>> _blogTypeMap = {
    'Normal': [],
    'Front Banner': [],
    'Recent': [],
    'Latest': [],
    'Most Popular': [],
    'Featured': []
  };

  Future<void> getBlogs({required String type, required int limit}) async {
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_BLOGS}?type=$type&limit=$limit');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Normal, Front Banner, Recent, Latest, Most Popular, Featured
        final List<BlogModels> blogs = BlogModels.blogsFromJson(jsonData);
        _blogTypeMap[type] = blogs;
        _assignBlogsToType();

        // if (type == 'Normal') {
        //   _normalBlogModel = BlogModels.blogsFromJson(jsonData);
        // } else if()

        // _blogModel = BlogModels.blogsFromJson(jsonData);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
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
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_BLOG_POST}?blog_id=$blogId');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        List<dynamic> content = jsonData['data']['blog_content'];

        _blogContent =
            content.map((data) => BlogContentModel.fromJson(data)).toList();

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  void selectCategory(String? value) {}
}

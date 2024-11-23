import 'package:digitalksp/models/author/author_models.dart';

import '../../constants/urls.dart';

class BlogModels {
  final String id;
  final String title;
  final String coverPhoto;
  final String coverTag;
  final String coverTitle;
  final String category;
  final String content;
  final String author;
  final String publishDate;
  final String blogDescription;
  final String publishedDate;
  final String updatedDate;
  final String status;
  final String remark;
  final String
      type; // Normal, Front Banner, Recent, Latest, Most Popular, Featured
  final String shareCount;
  final String userId;
  final AuthorModels authorModel;

  BlogModels({
    required this.id,
    required this.title,
    required this.coverPhoto,
    required this.coverTag,
    required this.coverTitle,
    required this.category,
    required this.content,
    required this.author,
    required this.publishDate,
    required this.blogDescription,
    required this.publishedDate,
    required this.updatedDate,
    required this.status,
    required this.remark,
    required this.type,
    required this.shareCount,
    required this.userId,
    required this.authorModel,
  });

  factory BlogModels.fromJson(Map<String, dynamic> json) {
    String imagePath = json['cover_photo'] ?? '';

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';

    return BlogModels(
      id: json["id"].toString(),
      title: json["title"] ?? '',
      coverPhoto: imageUrl,
      coverTag: json["cover_tag"] ?? '',
      coverTitle: json["cover_title"] ?? '',
      category: json["category"] ?? '',
      content: json["content"] ?? '',
      author: json["author"].toString(),
      publishDate: json["publish_date"] ?? '',
      blogDescription: json["blog_description"] ?? '',
      publishedDate: json["published_date"] ?? '',
      updatedDate: json["updated_date"] ?? '',
      status: json["status"] ?? '',
      remark: json["remark"] ?? '',
      type: json["type"] ?? '',
      shareCount: json["share_count"].toString(),
      userId: json["user_id"].toString(),
      authorModel: AuthorModels.fromJson(json['author_details']),
    );
  }

  static List<BlogModels> blogsFromJson(Map<String, dynamic> jsonData) {
    final List<dynamic> blogList = jsonData['data'] ?? [];
    return blogList.map((data) => BlogModels.fromJson(data)).toList();
  }
}

class BlogCategoryModel {
  final Map<String, dynamic> categories;

  const BlogCategoryModel({required this.categories});

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) {
    return BlogCategoryModel(categories: json['data']);
  }
}

import 'package:digitalksp/models/blogs/blog_models.dart';
import '../constants/urls.dart';

class BlogContentModel {
  final String id;
  final String blogId;
  final String headingType;
  final String heading;
  final String subHeadingType;
  final String subHeading;
  final String content;
  final String imageCategory;
  final List<String> imagePaths;
  final List<String> altTexts;

  const BlogContentModel({
    required this.id,
    required this.blogId,
    required this.headingType,
    required this.heading,
    required this.subHeadingType,
    required this.subHeading,
    required this.content,
    required this.imageCategory,
    required this.imagePaths,
    required this.altTexts,
  });

  factory BlogContentModel.fromJson(Map<String, dynamic> json) {
    List<String> imagePaths = [];
    List<String> altTexts = [];

    // Define the path and alt text keys
    final pathKeys = [
      'image_path',
      'image_path1',
      'image_path2',
      'image_path3',
      'image_path4'
    ];
    final altTextKeys = ['alt_text1', 'alt_text2', 'alt_text3', 'alt_text4'];

    for (var key in pathKeys) {
      String path = json[key] ?? '';
      if (path.startsWith('../')) {
        path = path.substring(3);
      }
      if (path.isNotEmpty) {
        imagePaths.add('${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$path');
      }
    }

    for (var key in altTextKeys) {
      altTexts.add(json[key] ?? '');
    }

    return BlogContentModel(
      id: json["id"].toString(),
      blogId: json["blog_id"].toString(),
      headingType: json["heading_type"] ?? '',
      heading: json["heading"] ?? '',
      subHeadingType: json["sub_heading_type"] ?? '',
      subHeading: json["sub_heading"] ?? '',
      content: json["content"] ?? '',
      imageCategory: json["image_category"] ?? '',
      imagePaths: imagePaths,
      altTexts: altTexts,
    );
  }
}

class BlogPostModel {
  final BlogModels blog;
  final List<BlogContentModel> content;

  const BlogPostModel({
    required this.blog,
    required this.content,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
      blog: BlogModels.fromJson(json["blog_data"]),
      content: List<BlogContentModel>.from(
          json['blog_content'].map((data) => BlogContentModel.fromJson(data))),
    );
  }
}

class SocialMediaModel {
  final String title;
  final String url;
  final String icon;

  const SocialMediaModel(
      {required this.title, required this.url, required this.icon});

  static final List<SocialMediaModel> generatedItem = [
    const SocialMediaModel(
        title: 'Facebook',
        url: 'https://www.facebook.com/',
        icon: 'assets/icons/social-media-facebook.svg'),
    const SocialMediaModel(
        title: 'Instagram',
        url: 'https://www.instagram.com/',
        icon: 'assets/icons/social-media-instagram.svg'),
    const SocialMediaModel(
        title: 'X',
        url: 'https://x.com/',
        icon: 'assets/icons/social-media-x.svg'),
    const SocialMediaModel(
        title: 'LinkedIn',
        url: 'https://www.linkedin.com/',
        icon: 'assets/icons/social-media-linkedin.svg'),
    const SocialMediaModel(
        title: 'YouTube',
        url: 'https://www.youtube.com/',
        icon: 'assets/icons/social-media-youtube.svg'),
  ];
}

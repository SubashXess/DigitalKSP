import '../../constants/urls.dart';

class AuthorModels {
  final String id;
  final String name;
  final String bio;
  final String photoUrl;
  final String blogCount;

  const AuthorModels({
    required this.id,
    required this.name,
    required this.bio,
    required this.photoUrl,
    required this.blogCount,
  });

  factory AuthorModels.fromJson(Map<String, dynamic> json) {
    String imagePath = json['profile_picture'];

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : 'assets/images/placeholder-user.png';

    return AuthorModels(
      id: json['id'].toString(),
      name: json['name'],
      bio: json['address'],
      photoUrl: imageUrl,
      blogCount: json['total_blogs'].toString(),
    );
  }

  static List<AuthorModels> authorsFromJson(Map<String, dynamic> jsonData) {
    final blog = jsonData['data']['authors'] as List;
    return blog.map((data) => AuthorModels.fromJson(data)).toList();
  }
}

class AuthorBlogCategoriesModel {
  final List<String> categories;

  const AuthorBlogCategoriesModel({required this.categories});

  factory AuthorBlogCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AuthorBlogCategoriesModel(
        categories: List<String>.from(json['data']));
  }

  // static List<AuthorBlogCategoriesModel> authorBlogCategoriesFromJson(
  //     Map<String, dynamic> jsonData) {
  //   final blog = jsonData['data'] as List;
  //   return blog
  //       .map((data) => AuthorBlogCategoriesModel.fromJson(data))
  //       .toList();
  // }
}

class BlogByAuthorModel {
  final String id;
  final String title;
  final String image;
  final String category;
  final String description;
  final String publishDate;

  const BlogByAuthorModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.category,
      required this.description,
      required this.publishDate});

  factory BlogByAuthorModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['cover_photo'];

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';

    return BlogByAuthorModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['blog_description'] ?? '',
      image: imageUrl,
      publishDate: json['publish_date'] ?? '',
    );
  }

  static List<BlogByAuthorModel> blogByAuthorFromJson(
      Map<String, dynamic> jsonData) {
    final blog = jsonData['data'] as List;
    return blog.map((data) => BlogByAuthorModel.fromJson(data)).toList();
  }
}


// 60 website


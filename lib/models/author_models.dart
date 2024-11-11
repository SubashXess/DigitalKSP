import '../constants/urls.dart';

class AuthorModels {
  final String id;
  final String name;
  final String bio;
  final String photoUrl;

  const AuthorModels(
      {required this.id,
      required this.name,
      required this.bio,
      required this.photoUrl});

  factory AuthorModels.fromJson(Map<String, dynamic> json) {
    String imagePath = json['profile_picture'];

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';

    return AuthorModels(
      id: json['id'],
      name: json['name'],
      bio: json['address'],
      photoUrl: imageUrl,
    );
  }

  static List<AuthorModels> authorsFromJson(Map<String, dynamic> jsonData) {
    final blog = jsonData['data']['authors'] as List;
    return blog.map((data) => AuthorModels.fromJson(data)).toList();
  }
}

class BlogByAuthorModel {
  final String title;
  final String image;
  final String category;
  final String description;
  final String publishDate;

  const BlogByAuthorModel(
      {required this.title,
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

